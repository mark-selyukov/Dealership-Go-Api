package service

import (
	"context"

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
	// s.db.MustExec(insertQuery, "BMW")

	// rows, err := s.db.QueryContext(ctx, listQuery)
	rows, err := s.db.QueryContext(ctx, "SELECT CURRENT_TIMESTAMP()")
	if err != nil {
		return nil, err
	}

	var arr []string
	for rows.Next() {
		var s string
		rows.Scan(&s)
		arr = append(arr, s)
	}
	return arr, nil
}