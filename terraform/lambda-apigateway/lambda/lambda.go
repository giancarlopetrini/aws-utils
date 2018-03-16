package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

// Request - lambda expects json with name key
type Request struct {
	Name string `json:"name"`
}

// Response - send back message
type Response struct {
	Message string `json:"message"`
}

// Handler - get name request, format and return response
func Handler(request Request) (Response, error) {
	return Response{
		Message: fmt.Sprintf("Hello, %s!", request.Name),
	}, nil
}

func main() {
	lambda.Start(Handler)
}
