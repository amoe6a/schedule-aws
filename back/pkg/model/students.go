package model

type StudentAddInfo struct {
	Students Students `json:"students"`
	Group    Groups   `json:"group"`
	Courses  Courses  `json:"courses"`
}

type Students struct {
	Id       int32    `json:"id,omitempty"`
	Name     string `json:"name,omitempty"`
	Username string `json:"username"`
	Password []byte `json:"-"`
}
