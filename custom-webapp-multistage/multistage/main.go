package main
import ("fmt"; "net/http"; "os"; "time")
func main() {
    port := os.Getenv("PORT"); if port == "" { port = "8080" }
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Multi-stage Go Webapp running at %s", time.Now().Format(time.RFC3339))
    })
    http.ListenAndServe(":"+port, nil)
}
