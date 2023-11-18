package main

import (
	"go-rest-api/initializers"
	"net/http"
	"github.com/gin-gonic/gin"
)

// represents data about User data
type User struct {
	ID string `json:"id"`
	Name string `json:"name"`
	Email string `json:"email"`
	Age string `json:"age"`
}

// user slice to seed user data
var users = []User{
	{ID: "1", Name: "Joseph Eshiett", Email: "josepheshiett@gmail.com", Age: "22"},
	{ID: "2", Name: "James Smith", Email: "johnsmith@email.com", Age: "20"},
	{ID: "3", Name: "John Doe", Email: "johndoe@email.com", Age: "30"},
}

// responds with list of all users
func getUsers(c *gin.Context){
	c.IndentedJSON(http.StatusOK, users)
}

// responds with users added
func addUser(c *gin.Context){
	var newUser User
	if err := c.BindJSON(&newUser); err != nil {
        return
    }
	users = append(users, newUser)
    c.IndentedJSON(http.StatusCreated, newUser)
}

// responds with singular user
func getUser(c *gin.Context){
	// parameter used for query of data
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

// Run function before main
func init(){
	// import initializers
	initializers.LoadEnvVars()
	initializers.ConnectToDB()

}
func main(){
	router := gin.Default()
	router.GET("/api/users", getUsers)
	router.GET("/api/user/:id", getUser)
	router.POST("api/user/:id", addUser)

	router.Run()
}