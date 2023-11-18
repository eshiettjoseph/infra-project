package models

import "gorm.io/gorm"

type User struct {
	gorm.Model
	ID string `json:"id"`
	Name string `json:"name"`
	Email string `json:"email"`
	Age string `json:"age"`
}