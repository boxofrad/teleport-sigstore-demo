package main

import (
	"context"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

func main() {
	if err := run(); err != nil {
		log.Fatal(err)
	}
}

func run() error {
	port := os.Getenv("PORT")
	if port == "" {
		return errors.New("PORT must be set")
	}

	bucketName := os.Getenv("S3_BUCKET_NAME")
	if bucketName == "" {
		return errors.New("S3_BUCKET_NAME must be set")
	}

	cfg, err := config.LoadDefaultConfig(context.Background())
	if err != nil {
		return err
	}

	return http.ListenAndServe(":"+port, handler{
		bucketName: bucketName,
		s3:         s3.NewFromConfig(cfg),
	})
}

type handler struct {
	s3         *s3.Client
	bucketName string
}

func (h handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	listRsp, err := h.s3.ListObjects(r.Context(), &s3.ListObjectsInput{
		Bucket: aws.String(h.bucketName),
	})
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Fprintf(w, "ERROR: %s\n", err)
		return
	}

	fmt.Fprintln(w, "Objects:")
	for _, obj := range listRsp.Contents {
		fmt.Fprintf(w, "- %s\n", aws.ToString(obj.Key))
	}
}
