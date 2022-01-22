package main

import (
	"fmt"
	"github.com/joho/godotenv"
	"github.com/spf13/viper"
	"log"
	"os"
	"schedule-aws/back/pkg"
	"schedule-aws/back/pkg/handler"
	repository2 "schedule-aws/back/pkg/repository"
	"schedule-aws/back/pkg/service"
	_ "github.com/swaggo/echo-swagger/example/docs"
)

// @title schedule-aws
// @version 1.0
// @description Simple app to see your schedule.
// @host localhost:8080
// @BasePath /
// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name Authorization
func main() {

	log.Println("starting program")

	if err := initConfig(); err != nil {
		log.Fatalf("error initializing configs: %s", err.Error())
	}

	if err := godotenv.Load(".env"); err != nil {
		log.Fatalf("error initializing env variables: %s\n", err.Error())
	}

	dbPool, err := repository2.NewPostgresDB(repository2.Config{
		Host: viper.GetString("db.host"),
		Port: viper.GetString("db.port"),
		Username: os.Getenv("DB_USERNAME"),
		Password: os.Getenv("DB_PASSWORD"),
		DBName: viper.GetString("db.name"),
	})

	defer dbPool.Close()

	if err != nil {
		_, _ = fmt.Fprintf(os.Stderr, "unable to connect to database: %v\n", err)
		os.Exit(1)
	}

	//e := echo.New()

	//e.GET("/lookusername", func(c echo.Context) error {
	//	username := c.FormValue("username")
	//	found := repository.FindUsername(username, dbPool)
	//	msg := "no"
	//	if found {
	//		msg = "yes"
	//	}
	//	data := map[string]string{}
	//	data["found"] = msg
	//	js, _ := json.Marshal(data)
	//	return c.JSONBlob(http.StatusOK, js)
	//})

	//e.Logger.Fatal(e.Start(":8080")) //1323

	repos := repository2.NewRepository(dbPool)
	services := service.NewService(repos)
	handlers := handler.NewHandler(services)

	server := pkg.NewServer()

	handlers.InitRoutes(server.EchoServer)


	if err := server.StartMyServer(viper.GetString("server.port")); err != nil {
		log.Fatalf("Error starting server %s", err)
	}

	//http.Handle("/", http.FileServer(http.Dir("./homepage")))
	//http.Handle("/addpage", http.FileServer(http.Dir("./add-student-page")))
	//http.ListenAndServe(":8080", nil)

	os.Exit(0)
}

func initConfig() error {
	viper.AddConfigPath("configs")
	viper.SetConfigName("config")
	return viper.ReadInConfig()
}