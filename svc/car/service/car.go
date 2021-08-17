package service

import (
	"context"
	"fmt"

	"github.com/jmoiron/sqlx"
)

type Car struct {
	db *sqlx.DB
}

func NewCar(db *sqlx.DB) Car {
	return Car{
		db: db,
	}
}

func (s Car) List(ctx context.Context, limit, skip uint) ([]string, error) {
	rows, err := s.db.QueryContext(ctx, listQuery)
	if err != nil {
		return nil, err
	}
	var arr []string
	for rows.Next() {
		var s string
		rows.Scan(&s)
		arr = append(arr, s)
	}
	fmt.Println("This is the arr")
	fmt.Println(arr)
	return arr, nil
}