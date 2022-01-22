package model

type ClassTime struct {
	Id   int    `json:"id" form:"id"`
	Name string `json:"name" form:"name"`
	Time string `json:"time" form:"time"`
}
