FROM golang
WORKDIR /go/src/github.com/habibridho/simple-go
ADD . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix .
EXPOSE 8888
ENTRYPOINT ./simple-go
