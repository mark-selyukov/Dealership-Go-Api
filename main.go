package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/go-chi/chi/v5"
	"gitlab.com/mark-selyukov-group/dealership-app/dealership-go-api/svc/car"
)

func runAPI() (err error) {
	r := chi.NewRouter()

	carHandler, err := car.InitHandler()
	if err != nil {
		return
	}
	r.Route("/api/cars", carHandler.Routes)

	server := http.Server{
		Addr: ":3000",
		Handler: r,
	}

	fmt.Println("Starting Server :)")

	return server.ListenAndServe()
}

func main() {
	if err := runAPI(); err != nil {
		fmt.Fprintf(os.Stderr, "Error starting api: %s\n", err)
		os.Exit(1)
	}
}