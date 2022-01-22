package model

type Courses struct {
	Names []string `json:"names" binding:"required"`
}
