# Go RESTful API
## TODO:
- Tools used: `github.com/githubnemo/CompileDaemon`, `github.com/joho/godotenv`, `github.com/gin-gonic/gin`, `gorm.io/gorm`, `gorm.io/driver/postgres`
- Add postgres database to store data
- Return current application status
- Accept JSON data and store in database
- Implement cache layer with Redis
- Implement logging, send logs to AWS cloudwatch
- Github workflow to test code, build docker image, push to dockerhub
- Write terraform script to provision server, database instance, security groups etc.
- Use Github actions to run terraform script to deploy the infrastructure