FROM golang:alpine as Builder 

ENV GO111MODULE=off CGO_ENABLED=0 GOOS=linux GOARCH=amd64

WORKDIR /tmp
COPY *.go .
RUN go build -ldflags="-s -w" -o hello-fullcycle

FROM scratch 

WORKDIR /tmp
COPY --from=Builder /tmp/hello-fullcycle /tmp/hello-fullcycle

ENTRYPOINT [ "/tmp/hello-fullcycle" ]