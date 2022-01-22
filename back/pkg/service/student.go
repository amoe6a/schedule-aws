package service

import (
	model2 "schedule-aws/back/pkg/model"
	"schedule-aws/back/pkg/repository"
)

type StudentService struct {
	repo repository.StudentInterface
}

func NewStudentService(repo repository.StudentInterface) *StudentService {
	return &StudentService{repo: repo}
}

func (s *StudentService) AddStudent(info model2.StudentAddInfo) (bool, error) {
	return s.repo.AddStudent(info)
}

func (s *StudentService) GiveSchedule(student model2.Students) ([]model2.ScheduleRow, error) {
	return s.repo.GiveSchedule(student)
}

func (s *StudentService) ShowMyClassmates(coursename string) ([]string, error) {
	return s.repo.ShowMyClassmates(coursename)
}

func (s *StudentService) ShowCourses() []string {
	return s.repo.ShowCourses()
}

func (s *StudentService) FindUsername(username string) error {
	return s.repo.FindUsername(username)
}

func (s *StudentService) GetUser(username string, id ...int) (*model2.Students, error) {
	if len(id) > 0 {
		return s.repo.GetUser(username, id[0])
	}
	return s.repo.GetUser(username)
}
