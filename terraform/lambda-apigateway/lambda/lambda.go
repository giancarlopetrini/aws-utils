package main

import (
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// Handler - Lambda function handler
func Handler(request events.APIGatewayProxyRequest) events.APIGatewayProxyResponse {

	// stdout and stderr are sent to AWS CloudWatch Logs
	log.Printf("Processing Lambda request %s\n", request.RequestContext.RequestID)

	// If no name is provided in the HTTP request body, throw an error
	if len(request.Body) < 1 {
		return events.APIGatewayProxyResponse{
			Body:       "Welcome to apitest.giancarlopetrini.com",
			StatusCode: 200,
		}
	}

	return events.APIGatewayProxyResponse{
		Body:       "Hello " + request.Body,
		StatusCode: 200,
	}

}

func main() {
	lambda.Start(Handler)
}
