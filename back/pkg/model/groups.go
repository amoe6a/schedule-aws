package model

type Groups struct {
	Id       int    `json:"id,omitempty"`
	Name     string `json:"name" form:"name" binding:"required"`
}
