package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

type User struct {
	ID string `json:"id"`
	Name string `json:"name"`
	Email string `json:"email"`
	Age string `json:"age"`
}

var users = []User{
	{ID: "1", Name: "Joseph Eshiett", Email: "josepheshiett@gmail.com", Age: "22"},
	{ID: "2", Name: "James Smith", Email: "johnsmith@email.com", Age: "20"},
	{ID: "2", Name: "John Doe", Email: "johndoe@email.com", Age: "30"},
}

func getUsers(c *gin.Context){
	c.IndentedJSON(http.StatusOK, users)
}

func addUser(c *gin.Context){
	var newUser User
	if err := c.BindJSON(&newUser); err != nil {
        return
    }
	users = append(users, newUser)
    c.IndentedJSON(http.StatusCreated, newUser)
}

func getUser(c *gin.Context){
	id := c.Param("id")

    // Loop through the list of albums, looking for
    // an album whose ID value matches the parameter.
    for _, a := range users {
        if a.ID == id {
            c.IndentedJSON(http.StatusOK, a)
            return
        }
    }
    c.IndentedJSON(http.StatusNotFound, gin.H{"message": "user not found"})
}

func main(){
	router := gin.Default()
	router.GET("/api/users", getUsers)
	router.GET("/api/user/:id", getUser)
	router.POST("api/user/:id", addUser)

	router.Run("localhost:8080")
}