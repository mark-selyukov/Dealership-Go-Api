package handler

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
	"gitlab.com/mark-selyukov-group/dealership-app/dealership-go-api/svc/car/service"
)

type Car struct {
	carService service.Car
}

func NewCar(carService service.Car) Car {
	return Car{carService: carService}
}

func (h Car) Routes(r chi.Router) {
	r.Get("/", h.List)
}

func (h Car) List(w http.ResponseWriter, r *http.Request) {
	carList, err := h.carService.List(r.Context(), 10, 0)
	if err != nil{
		w.WriteHeader(http.StatusInternalServerError)
		fmt.Fprint(w, err)
		return
	}
	fmt.Fprint(w, carList)
}