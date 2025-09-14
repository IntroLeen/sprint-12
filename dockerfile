# syntax=docker/dockerfile:1
FROM golang:1.24-alpine AS build
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
ENV CGO_ENABLED=0
RUN go build -o app ./...

FROM alpine:3.20
WORKDIR /app
COPY --from=build /src/app /usr/local/bin/app
ENTRYPOINT ["/usr/local/bin/app"]
# EXPOSE 8080
