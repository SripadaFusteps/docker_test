FROM golang
WORKDIR /go/src/github.com/SripadaFusteps/docker_test
ADD . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix .
EXPOSE 8888
ENTRYPOINT ./docker_test
