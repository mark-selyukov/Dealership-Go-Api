package config

import (
	"fmt"
	"os"
	"strconv"
)

type Struct struct{
	Port int
	DatabaseURL string
}

var currentConfig *Struct

func envStr(key, defaultValue string) string {
	val := os.Getenv(key)
	if val == "" {
		return defaultValue
	}
	return val
}

func envInt(key string, defaultValue int) int {
	val, err := strconv.Atoi(os.Getenv(key))
	if err != nil {
		return defaultValue
	}
	return val
}

func Read() {
	currentConfig = &Struct{
		Port: envInt("PORT", 3000),
		DatabaseURL: envStr("DATABASE_URL", "mysql:mysql@tcp(localhost:3306)/car_dev"),
	}
	fmt.Println("The current port is: ", currentConfig.Port)
	fmt.Println("The current url is: ", currentConfig.DatabaseURL)
}

func Current() *Struct {
	return currentConfig
}