
FROM golang:1.22-alpine AS build
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app ./...


FROM alpine:3.20
WORKDIR /app

COPY --from=build /src/app /usr/local/bin/app
COPY tracker.db /app/tracker.db


ENTRYPOINT ["/usr/local/bin/app"]
