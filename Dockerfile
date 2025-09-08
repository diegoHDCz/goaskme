
FROM golang:1.22-alpine AS builder


WORKDIR /app


COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /app/ternsdotenv ./cmd/tools/terndotenv/main.go


RUN CGO_ENABLED=0 go build -o /app/wsrs ./cmd/tools/wsrs/main.go

FROM alpine:latest


WORKDIR /usr/local/bin


COPY --from=builder /app/ternsdotenv .
COPY --from=builder /app/wsrs .


ENTRYPOINT ["sh", "-c", "./ternsdotenv && ./wsrs"]