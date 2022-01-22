package service

import (
	model2 "schedule-aws/back/pkg/model"
	"schedule-aws/back/pkg/repository"
)

type Student interface {
	AddStudent(info model2.StudentAddInfo) (bool, error)
	GiveSchedule(student model2.Students) ([]model2.ScheduleRow, error)
	ShowMyClassmates(coursename string) ([]string, error)
	ShowCourses() []string
	FindUsername(username string) error
	GetUser(username string, id ...int) (*model2.Students, error)
}

type Service struct {
	Student
}

func NewService(repos *repository.Repository) *Service {
	return &Service{
		Student: NewStudentService(repos.StudentInterface),
	}
}
