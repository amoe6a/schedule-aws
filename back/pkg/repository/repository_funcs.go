package repository

import (
	"context"
	"errors"
	"github.com/jackc/pgx/v4/pgxpool"
	"log"
	"schedule-aws/back/pkg/model"
)

type StudentPostgres struct {
	dbPool *pgxpool.Pool
}

func NewStudentPostgres(dbPool *pgxpool.Pool) *StudentPostgres {
	return &StudentPostgres{dbPool: dbPool}
}

type StudentInterface interface {
	AddStudent(info model.StudentAddInfo) (bool, error)
	GiveSchedule(student model.Students) ([]model.ScheduleRow, error)
	ShowMyClassmates(coursename string) ([]string, error)
	ShowCourses() []string
	FindUsername(username string) error
	GetUser(username string, id ...int) (*model.Students, error)
}

type Repository struct {
	StudentInterface
}

func NewRepository(dbPool *pgxpool.Pool) *Repository {
	return &Repository{
		StudentInterface: NewStudentPostgres(dbPool),
	}
}

// GetUser gives user based on the id, if present, else gives based on the username
func (s *StudentPostgres) GetUser(username string, id ...int) (*model.Students, error) {
	if len(id) > 0 {
		if id[0] == 0 {
			return nil, errors.New("id is 0")
		}
		rows, err := s.dbPool.Query(context.Background(), "select username, password from public.students where id=($1)", id[0])
		if err != nil {
			log.Println("Could not connect to db")
			return nil, err
		}
		rows.Next()
		row, err := rows.Values()
		if err != nil {
			log.Println("The User was not found")
			return nil, err
		}
		var password []byte
		if row[1] == nil {
			password = []byte("")
		} else {
			password = []byte(row[1].(string))
		}
		user := model.Students{
			Id:		int32(id[0]),
			Name:     "",
			Username: row[0].(string),
			Password: password,
		}
		return &user, nil
	}

	rows, err := s.dbPool.Query(context.Background(), "select id, password from public.students where username=$1", username)
	if err != nil {
		log.Println("Could not connect to db")
		return nil, err
	}
	rows.Next()
	row, err := rows.Values()
	if err != nil {
		log.Println("User was not found")
		return nil, err
	}
	var password []byte
	if row[1] == nil {
		password = []byte("")
	} else {
		password = []byte(row[1].(string))
	}
	user := model.Students{
		Id:       row[0].(int32),
		Name:     "",
		Username: username,
		Password: password,
	}
	return &user, nil
}

// FindUsername true if username was found
func (s *StudentPostgres) FindUsername(username string) error {
	rows, err := s.dbPool.Query(context.Background(), "select username from public.students where username=$1", username)
	if err != nil {
		log.Println("Could not connect to db")
		return err
	}
	rows.Next()
	_, err = rows.Values()
	if err != nil {
		log.Println("User was not found")
		return err
	}
	return nil
}

func (s *StudentPostgres) ShowMyClassmates(coursename string) ([]string, error) {
	var names []string

	rows, err := s.dbPool.Query(context.Background(), "select S.name from public.students S join" +
		" (select CP.id_students from public.class_time CT join" +
		" public.class_participants CP on CT.id=CP.id_class where CT.name=$1) T" +
		" on S.id = T.id_students", coursename)
	if err != nil {
		log.Println("Can not see the courses")
		return nil, err
	}

	for rows.Next() {
		row, _ := rows.Values()
		names = append(names, row[0].(string))
	}
	return names, nil
}

func (s *StudentPostgres) ShowCourses() []string {
	rows, err := s.dbPool.Query(context.Background(), "select name from public.class_time")
	if err != nil {
		log.Println("Can not see the courses")
		return nil
	}
	var courses []string
	for rows.Next() {
		row, _ := rows.Values()
		courses = append(courses, row[0].(string))
	}
	return courses
}

func (s *StudentPostgres) AddStudent(info model.StudentAddInfo) (bool, error) {
	fullName := info.Students.Name
	username := info.Students.Username
	password := info.Students.Password
	groupname := info.Group.Name
	coursenames := info.Courses.Names
	var studentid int32
	var groupid int32
	var classid int32

	if s.FindUsername(username) == nil {
		log.Println("Such username already exists")
		return false, errors.New("Such username already exists")
	}

	_, err := s.dbPool.Exec(context.Background(), "insert into public.students (name, username, password) values ($1, $2, $3);", fullName, username, password)
	if err != nil {
		log.Println("Can not add the student")
		return false, errors.New("Registration failed for an internal problem")
	}

	rows, err := s.dbPool.Query(context.Background(), "select id from public.students where username=$1;", username)
	if err != nil {
		log.Println("Can not find the student")
		return false, errors.New("Registration failed for an internal problem")
	}
	
	rows.Next()
	row, _ := rows.Values()
	studentid = row[0].(int32)

	rows, err = s.dbPool.Query(context.Background(), "select id from public.groups where name=$1;", groupname)
	if err != nil {
		log.Println("Could not query the 'groups' table")
		return false, errors.New("Registration failed for an internal problem")
	}

	rows.Next()
	row, _ = rows.Values()
	if len(row) == 0 {
		log.Println("Can not find group with such name")
		return false, errors.New("Such group does not exist")
	} else {
		groupid = row[0].(int32)
	}
	
	_, err = s.dbPool.Exec(context.Background(), "insert into public.groups_students (id_groups, id_students) values ($1, $2);", groupid, studentid)
	if err != nil {
		log.Println("Can not add the groups_student")
		return false, errors.New("Registration failed for an internal problem")
	}

	for _, name := range coursenames {
		rows, err := s.dbPool.Query(context.Background(), "select id from public.class_time where name=$1;", name)
		if err != nil {
			log.Println("Can not find class with such name")
			return false, errors.New("Such course does not exist")
		}

		rows.Next()
		row, _ = rows.Values()
		classid = row[0].(int32)

		_, err = s.dbPool.Exec(context.Background(), "insert into public.class_participants (id_class, id_students) values ($1, $2);", classid, studentid)
		if err != nil {
			log.Println("Can not add the class_participants")
			return false, errors.New("Registration failed for an internal problem")
		}
	}
	return true, nil
}

func (s *StudentPostgres) GiveSchedule(student model.Students) ([]model.ScheduleRow, error) {
	var scheduleSlice []model.ScheduleRow
	username := student.Username
	log.Println("starting execution of ShowSchedule query")
	log.Println("the username is: " + username)
	ids, err := s.dbPool.Query(context.Background(), "select id from public.students where username=$1", username)
	if err != nil {
		return nil, errors.New("no such username")
	}

	var id int32
	id = 0
	for ids.Next() {
		val, err := ids.Values()
		if err != nil {
			return nil, errors.New("query was empty")
		}
		id = val[0].(int32)
	}

	classRows, err := s.dbPool.Query(context.Background(), "SELECT public.class_time.name, public.class_time.time " +
		"FROM public.class_time " +
		"LEFT JOIN public.class_participants ON public.class_time.id = public.class_participants.id_class " +
		"WHERE public.class_participants.id_students=($1);", id)
	if err != nil {
		return nil, err
	}

	index := 0
	for classRows.Next() {
		classDates, _ := classRows.Values()
		scheduleSlice = append(scheduleSlice, model.ScheduleRow{Name: classDates[0].(string), Time: classDates[1].(string)})
		index++
	}
	if index == 0 {
		log.Println("User do not attend any class")
		// changed return from 'nil, err' to 'nil, nil', so that on the outside (handler file 'student.go')
		// it would be clear that user does not attend classes
		return nil, nil
	}
	return scheduleSlice, nil
}

//func (s *StudentPostgres) GiveSchedule(student model.Students) (string, error) {
//	var scheduleSlice []model.ScheduleRow
//	username := student.Username
//	log.Println("starting execution of ShowSchedule query")
//	log.Println("the username is: " + username)
//	ids, err := s.dbPool.Query(context.Background(), "select id from public.students where username=$1", username)
//	if err != nil {
//		return "", errors.New("no such username")
//	}
//
//	var id int32
//	id = 0
//	for ids.Next() {
//		val, err := ids.Values()
//		if err != nil {
//			return "", errors.New("query was empty")
//		}
//		id = val[0].(int32)
//	}
//
//	classRows, err := s.dbPool.Query(context.Background(), "SELECT public.class_time.name, public.class_time.time " +
//															"FROM public.class_time " +
//															"LEFT JOIN public.class_participants ON public.class_time.id = public.class_participants.id_class " +
//															"WHERE public.class_participants.id_students=($1);", id)
//	if err != nil {
//		return "", err
//	}
//
//	index := 0
//	for classRows.Next() {
//		classDates, _ := classRows.Values()
//		scheduleSlice = append(scheduleSlice, model.ScheduleRow{Name: classDates[0].(string), Time: classDates[1].(string)})
//		index++
//	}
//	if index == 0 {
//		return "", errors.New("you do not attend any class")
//	}
//	htmlString := ""
//	tmpString := ""
//	htmlString1 := "<!DOCTYPE html>" +
//		"<html lang=\"en\">" +
//		"<head>" +
//		"    <meta charset=\"UTF-8\">" +
//		"    <title>Title</title>" +
//		"</head>" +
//		"<body>" +
//		"	<table>" +
//		"  	<tr>" +
//		"	    <th>Class Name</th>" +
//		"    	<th>Class Time</th>" +
//		"  	</tr>"
//	htmlString += htmlString1
//	for _, each := range scheduleSlice {
//		tmpString = "<tr>" + "<td>" + each.Name + "</td>" + "<td>" + each.Time + "</td>" + "</tr>"
//		htmlString += tmpString
//	}
//	htmlString2 := "	</table> " +
//		"</body>" +
//		"</html>"
//	htmlString += htmlString2
//	return htmlString, nil
//}

func SelectStudents(dbPool *pgxpool.Pool) {
	log.Println("starting execution of select query")
	rows, err := dbPool.Query(context.Background(), "select * from public.students")
	if err != nil {
		log.Println("error while executing query")
	}

	log.Println("result:")
	//iterate through the rows
	for rows.Next() {
		values, err := rows.Values()
		if err != nil {
			log.Println("error while iterating dataset")
		}
		//convert DB types to Go types
		id := values[0].(int32)
		name := values[1].(string)
		log.Println("[id:", id, ", name:", name, "]")
	}
}
