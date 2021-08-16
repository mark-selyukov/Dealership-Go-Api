package client

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

var currentDB *sqlx.DB

func NewMySQL() (db *sqlx.DB, err error) {
	if currentDB == nil {
		// currentDB, err = sqlx.Connect("mysql", "mysql:mysql@tcp(localhost:3306)/car_dev")
		// currentDB, err = sqlx.Connect("mysql", "mysql:mysql@tcp(mysql)/car_dev")
		// currentDB, err = sqlx.Connect("mysql", "mysql://mysql:mysql@mysql/car_dev")
		currentDB, err = sqlx.Connect("mysql", "mysql://mysql@(mysql:3306)/car_dev")
	}
	db = currentDB
	return
}