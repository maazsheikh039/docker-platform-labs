FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY main.go .
RUN go build -o webapp main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/webapp .
EXPOSE 8080
CMD ["./webapp"]

