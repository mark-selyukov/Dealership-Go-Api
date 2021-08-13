package service

import _ "embed"

var (
	//go:embed sql/list.sql
	listQuery string
)