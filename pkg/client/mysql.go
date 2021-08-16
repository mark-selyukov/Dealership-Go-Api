package client

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
	"gitlab.com/mark-selyukov-group/dealership-app/dealership-go-api/pkg/config"
)

var currentDB *sqlx.DB

func NewMySQL() (db *sqlx.DB, err error) {
	if currentDB == nil {
		cfg := config.Current()
		currentDB, err = sqlx.Connect("mysql", cfg.DatabaseURL)
	}
	db = currentDB
	return
}