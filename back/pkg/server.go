package pkg

import (
	"context"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	_ "github.com/swaggo/echo-swagger/example/docs"
	"net/http"
)

type MyServer struct {
	EchoServer *echo.Echo
}

func (s *MyServer) StartMyServer(port string) error {
	s.EchoServer.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		//Skipper:      SkipperFunc,
		AllowOrigins: []string{"*"},
		AllowMethods: []string{http.MethodGet, http.MethodHead, http.MethodPut, http.MethodPatch, http.MethodPost, http.MethodDelete},
		AllowCredentials: true,
	}))
	err := s.EchoServer.Start(port)
	if err != nil {
		s.EchoServer.Logger.Fatal(err)
	}

	return err
}

func (s *MyServer) CloseMyServer(ctx context.Context) error {
	return s.EchoServer.Shutdown(ctx)
}

func NewServer() *MyServer {
	return &MyServer{
		EchoServer: echo.New(),
	}
}
