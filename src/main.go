package main

import (
	"go-rest-api/controllers"
	"go-rest-api/initializers"
	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// represents data about User data

// responds with list of all users

// Run function before main
func init(){
	// import initializers
	// initializers.LoadEnvVars()
	initializers.ConnectToDB()
}

var (
	// Prometheus metrics custom config
	httpRequestsTotal = promauto.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total",
			Help: "Total number of HTTP requests",
		},
		[]string{"path"},
	)

	httpRequestDuration = promauto.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "http_request_duration_seconds",
			Help:    "Duration of HTTP requests in seconds",
			Buckets: prometheus.DefBuckets,
		},
		[]string{"path"},
	)
)

func main(){

	router := gin.Default()

	// Middleware to collect metrics
	router.Use(func(c *gin.Context) {
		path := c.Request.URL.Path
		timer := prometheus.NewTimer(httpRequestDuration.WithLabelValues(path))
		c.Next() // Process request
		httpRequestsTotal.WithLabelValues(path).Inc()
		timer.ObserveDuration()
	})

	router.POST("/api/user/", controllers.AddUser)
	// Prometheus metrics endpoint
	router.GET("/metrics", gin.WrapH(promhttp.Handler()))
	router.GET("/api/users/", controllers.GetUsers)
	router.GET("/api/user/:id", controllers.GetUser)
	router.DELETE("/api/user/:id", controllers.DeleteUser)
	router.PUT("/api/user/:id", controllers.UpdateUser)
	router.PUT("/status", controllers.Status)

	router.Run()
}