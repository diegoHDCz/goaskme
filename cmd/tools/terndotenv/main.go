package main

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
)

func main() {
	var out bytes.Buffer
	var stderr bytes.Buffer
fmt.Println("USER:", os.Getenv("WSRS_DATABASE_USER"))
fmt.Println("PASS:", os.Getenv("WSRS_DATABASE_PASSWORD"))
fmt.Println("HOST:", os.Getenv("WSRS_DATABASE_HOST"))
	fmt.Println("PORT:", os.Getenv("WSRS_DATABASE_PORT"))
fmt.Println("NAME:", os.Getenv("WSRS_DATABASE_NAME"))
	cmd := exec.Command(
		 "tern",
    "migrate",
    "--migrations",
    "/app/internal/store/pgstore/migrations",
    "--config",
    "/app/internal/store/pgstore/migrations/tern.conf",
	)

	cmd.Stdout = &out
	cmd.Stderr = &stderr

	err := cmd.Run()
	if err != nil {
		fmt.Println("STDOUT:", out.String())
		fmt.Println("STDERR:", stderr.String())
		panic(err)
	}
}
