package main

import "net/http"

func main() {
	println("Hello, World!")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err)
	}
}
