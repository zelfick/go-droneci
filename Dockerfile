# Multi-stage Version - Final image size aprox 11MB

FROM golang:1.10-alpine3.7 as builder
WORKDIR /go/src/go-droneci/main
COPY . .
RUN go get -d ./... && go build -o main .

FROM alpine:3.8
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/go-droneci/main .

EXPOSE 8080
ENTRYPOINT ./main
