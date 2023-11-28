FROM  golang:1.21-alpine AS build

RUN apk add --no-cache git

WORKDIR /tmp/go-rest-api

COPY src .

RUN go mod download

RUN go build -o /out/go-rest-api .

FROM alpine:3.9

COPY --from=build /tmp/go-rest-api/out/go-rest-api /app/go-rest-api

EXPOSE 3000


CMD ["/app/go-rest-api"]