package main

import (
	"fmt"
	"net/http"
)

func homeHandler(w http.ResponseWriter, r *http.Request) {
	// Serve the HTML file
	http.ServeFile(w, r, "index.html")
}

func submitHandler(w http.ResponseWriter, r *http.Request) {
	// Parse the form data
	err := r.ParseForm()
	if err != nil {
		http.Error(w, "Failed to parse form", http.StatusBadRequest)
		return
	}

	// Get the input value from the form
	input := r.FormValue("input")

	// Return the response
	fmt.Fprintf(w, "You submitted: %s", input)
}

func main() {
	// Serve the HTML file at the root route
	http.HandleFunc("/", homeHandler)

	// Handle form submissions at the /submit route
	http.HandleFunc("/submit", submitHandler)

	// Start the server on port 8080
	fmt.Println("Server is running on http://localhost:8080")
	http.ListenAndServe(":8080", nil)
}
