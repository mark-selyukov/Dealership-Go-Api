package car

import (
	"gitlab.com/mark-selyukov-group/dealership-app/dealership-go-api/pkg/client"
	"gitlab.com/mark-selyukov-group/dealership-app/dealership-go-api/svc/car/handler"
	"gitlab.com/mark-selyukov-group/dealership-app/dealership-go-api/svc/car/service"
)

func InitHandler() (h handler.Car, err error) {
	db, err := client.NewMySQL()
	if err != nil {
		return
	}
	carService := service.NewCar(db)
	h = handler.NewCar(carService)
	return
}