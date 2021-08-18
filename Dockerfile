FROM golang:1.16-alpine AS builder

WORKDIR /go/src

COPY go.* ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o app .

FROM scratch

WORKDIR /app

COPY --from=builder /go/src/app .

# Since we started from scratch, we'll copy the SSL root certificates from the builder
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

EXPOSE 80

ENTRYPOINT ["./app"]