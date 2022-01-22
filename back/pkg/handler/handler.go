package handler

import (
	"github.com/labstack/echo/v4"
	echoSwagger "github.com/swaggo/echo-swagger"
	_ "github.com/swaggo/echo-swagger/example/docs"
	"schedule-aws/back/pkg/service"
)

type Handler struct {
	services *service.Service
}

func NewHandler(services *service.Service) *Handler {
	return &Handler{services: services}
}

func (h *Handler) InitRoutes(router *echo.Echo) *echo.Echo {

	//loadaddstudentpage := router.Group("/addpage")
	//{
	//	loadaddstudentpage.GET("", h.LoadAddStudentPage)
	//}
	//
	//loadhomepage := router.Group("")
	//{
	//	loadhomepage.GET("", h.LoadHomepage)
	//}

	swagger := router.Group("/swagger")
	{
		swagger.GET("/*", echoSwagger.WrapHandler)
	}

	student := router.Group("/student")
	{
		student.POST("/register", h.AddStudent)
		student.POST("/login", h.Login)
		student.GET("/user", h.User)
		student.POST("/logout", h.Logout)
		student.POST("/find", h.FindUsername)
		student.POST("/schedule", h.GiveSchedule)
	}

	courses := router.Group("/course")
	{
		courses.GET("/all", h.ShowCourses)
		courses.POST("/participants", h.ShowMyClassmates)
	}

	return router
}
