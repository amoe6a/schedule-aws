package handler

import (
	"encoding/json"
	"github.com/dgrijalva/jwt-go"
	"github.com/labstack/echo/v4"
	"golang.org/x/crypto/bcrypt"
	"io"
	"log"
	"net/http"
	"schedule-aws/back/pkg/model"
	"strconv"
	"time"
	"unicode"
)

const SecretKey = "some_secret"

// ShowMyClassmates
// @Summary ShowMyClassmates
// @Tags Core
// @Description shows a particular course participants
// @ID show-classmates
// @Accept json
// @Produce json
// @Success 200 {object} []string
// @Failure 400 {object} string
// @Router /course/participants [post]
func (h *Handler) ShowMyClassmates(c echo.Context) error {
	coursename := c.FormValue("coursename")
	names, err := h.services.Student.ShowMyClassmates(coursename)
	if err != nil {
		return c.JSON(http.StatusBadRequest, "Could not find classmates")
	}

	if len(names) == 0 {
		return c.JSON(http.StatusOK, "You have no classmates(")
	}

	return c.JSON(http.StatusOK, names)
}

// ShowCourses
// @Summary ShowCourses
// @Tags Support
// @Description shows available to choose courses
// @ID show-courses
// @Accept json
// @Produce json
// @Success 200 {object} []string
// @Failure 400 {object} string
// @Router /course/all [post]
func (h *Handler) ShowCourses(c echo.Context) error {
	courses := h.services.Student.ShowCourses()
	if courses == nil {
		return c.JSON(http.StatusBadRequest, "Could not show courses")
	}
	return c.JSON(http.StatusOK, courses)
}
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDI1OTYwMDQsImlzcyI6IjEwOCJ9.icKsd8GzS3DfxSXIyAxSTp9CZG_CDIUJdGGL-o3ja-0

// HasSpaceChars checks for illegal 'space'-like chars in a password (chars like \n, \t, ' ', \f, \v, ...)
func HasSpaceChars(password string) bool {
	for _, char := range password {
		if unicode.IsSpace(char) {
			return true
		}
	}
	return false
}

// AddStudent
// @Summary AddStudent
// @Tags Core
// @Description Create/add student
// @ID create-account
// @Accept json
// @Produce json
// @Param input body model.StudentAddInfo true "Student info"
// @Success 200 {object} map[string]interface{}
// @Failure 400 {object} map[string]interface{}
// @Router /student/register [post]
func (h *Handler) AddStudent(c echo.Context) error {
	var studentAddInfo model.StudentAddInfo
	var data map[string]map[string]interface{}

	b, err := io.ReadAll(c.Request().Body)
	if err != nil {
		log.Println(err)
	}

	err = json.Unmarshal(b, &data)
	if err != nil {
		log.Println(err)
	}

	err = json.Unmarshal(b, &studentAddInfo)
	if err != nil {
		log.Println(err)
	}

	// group name does not unmarshal into the studentAddInfo, so that is the way to go
	studentAddInfo.Group.Name = data["group"]["groupName"].(string)

	if HasSpaceChars(data["students"]["password"].(string)) {
		return c.JSON(http.StatusBadRequest, map[string]interface{}{
			"success": "false",
			"message": "Password can not contain 'space'-like characters",
		})
	}

	studentAddInfo.Students.Password, _ = bcrypt.GenerateFromPassword([]byte(data["students"]["password"].(string)), 14)

	res, err := h.services.Student.AddStudent(studentAddInfo)

	if !res {
		return c.JSON(http.StatusBadRequest, map[string]interface{}{
			"success": "false",
			"message": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"success": "true",
		"message": "",
	})
}

// GiveSchedule
// @Summary GiveSchedule
// @Tags Core
// @Description Give students' schedule
// @ID give-schedule
// @Accept json
// @Produce json
// @Param input body model.Students true "Students' info"
// @Success 200 {object} []model.ScheduleRow
// @Failure 400 {object} map[string]interface{}
// @Router /student/schedule [post]
func (h *Handler) GiveSchedule(c echo.Context) error {
	var student model.Students

	b, err := io.ReadAll(c.Request().Body)
	if err != nil {
		log.Fatal(err)
	}
	err = json.Unmarshal(b, &student)
	if err != nil {
		log.Println(err)
	}

	scheduleSlice, err := h.services.Student.GiveSchedule(student)

	if scheduleSlice == nil && err == nil {
		var emptyMessage []model.ScheduleRow
		emptyMessage = append(emptyMessage, model.ScheduleRow{
			Name: "You do not attend any class",
			Time: "",
		})
		return c.JSON(http.StatusOK, emptyMessage)
	}

	if err != nil {
		return c.JSON(http.StatusBadRequest, map[string]interface{}{
			"error": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, scheduleSlice)
}

// FindUsername
// @Summary FindUsername
// @Tags Support
// @Description Check whether username exists in db
// @ID find-username
// @Accept json
// @Produce json
// @Success 200 {object} string
// @Failure 400 {object} string
// @Router /student/find [post]
func (h *Handler) FindUsername(c echo.Context) error {
	username := c.FormValue("username")
	err := h.services.Student.FindUsername(username)
	if err != nil {
		return c.JSON(http.StatusOK, "false")
	}
	return c.JSON(http.StatusOK, "true")
}

type UsernameAndPassword struct {
	Username string `json:"username"`
	StringPassword string `json:"password"`
}

// Login
// @Summary Login
// @Tags Core
// @Description Login handler
// @ID login
// @Accept json
// @Produce json
// @Success 200 {object} map[string]interface{}
// @Failure 400 {object} map[string]interface{}
// @Failure 404 {object} map[string]interface{}
// @Failure 500 {object} map[string]interface{}
// @Router /student/login [post]
func (h *Handler) Login(c echo.Context) error {
	var logInfo UsernameAndPassword

	b, err := io.ReadAll(c.Request().Body)
	if err != nil {
		log.Println(err)
	}

	err = json.Unmarshal(b, &logInfo)
	if err != nil {
		log.Println(err)
	}

	if HasSpaceChars(logInfo.StringPassword) {
		return c.JSON(http.StatusBadRequest, map[string]interface{}{
			"message": "password can not contain 'space'-like characters",
		})
	}

	username := logInfo.Username
	password := []byte(logInfo.StringPassword)

	if h.services.Student.FindUsername(username) != nil {
		return c.JSON(http.StatusNotFound, map[string]interface{}{
			"message": "user not found",
		})
	}

	user, err := h.services.Student.GetUser(username)
	if err != nil {
		return c.JSON(http.StatusNotFound, map[string]interface{}{
			"message": "user not found",
		})
	}

	if err := bcrypt.CompareHashAndPassword(user.Password, password); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]interface{}{
			"message": "incorrect password",
		})
	}

	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.StandardClaims{
		Issuer:    strconv.Itoa(int(user.Id)),
		ExpiresAt: time.Now().Add(time.Hour * 24).Unix(), //1 day
	})
	// to edit token
	token, err := claims.SignedString([]byte(SecretKey))
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]interface{}{
			"message": "could not login",
		})
	}

	cookie := new(http.Cookie)
	cookie.Name = "jwt"
	cookie.Value = token
	cookie.Expires = time.Now().Add(time.Hour * 24)
	cookie.HttpOnly = true
	c.SetCookie(cookie)

	return c.JSON(http.StatusOK, map[string]interface{}{
		"message": "",
		"name": username,
	})
}

// User
// @Summary User
// @Tags Core
// @Description Gives the current user's data
// @ID user
// @Accept json
// @Produce json
// @Success 200 {object} model.Students
// @Failure 401 {object} map[string]interface{}
// @Failure 404 {object} map[string]interface{}
// @Router /student/user [get]
func (h *Handler) User(c echo.Context) error {
	cookies := c.Cookies()
	if len(cookies) == 0 {
		return c.JSON(http.StatusUnauthorized, map[string]interface{}{
			"message": "unauthenticated",
		})
	}
	cookie, err := c.Cookie("jwt")
	if err != nil {
		return err
	}
	token, err := jwt.ParseWithClaims(cookie.Value, &jwt.StandardClaims{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(SecretKey), nil
	})

	if err != nil {
		return c.JSON(http.StatusUnauthorized, map[string]interface{}{
			"message": "unauthenticated",
		})
	}

	claims := token.Claims.(*jwt.StandardClaims)
	issuerId, _ := strconv.Atoi(claims.Issuer)
	user, err := h.services.Student.GetUser("", issuerId)
	if err != nil {
		return c.JSON(http.StatusNotFound, map[string]interface{}{
			"message": "issuer not found",
		})
	}
	log.Println(user)
	return c.JSON(http.StatusOK, user)
}

// Logout
// @Summary Logout
// @Tags Core
// @Description Logs out
// @ID logout
// @Accept json
// @Produce json
// @Success 200 {object} map[string]interface{}
// @Router /student/logout [post]
func (h *Handler) Logout(c echo.Context) error {
	cookie := new(http.Cookie)
	cookie.Name = "jwt"
	cookie.Value = ""
	cookie.Expires = time.Now().Add(-time.Hour)
	cookie.HttpOnly = true
	c.SetCookie(cookie)

	return c.JSON(http.StatusOK, map[string]interface{}{
		"message": "successful logout",
	})
}

//func (h *Handler) LoadHomepage(c echo.Context) error {
//	return c.File("homepage/index.html")
//}
//
//func (h *Handler) LoadAddStudentPage(c echo.Context) error {
//	return c.File("add-student-page/index.html")
//}