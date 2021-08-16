FROM golang:1.16-alpine

WORKDIR /go/src/app

# COPY pkg ./
# COPY svc ./
# COPY go.mod ./
# COPY go.sum ./
# RUN go mod download

# COPY *.go ./
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...
# RUN go build

EXPOSE 8181

CMD ["dealership-go-api"]