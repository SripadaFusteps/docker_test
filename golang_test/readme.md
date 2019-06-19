# How we deploy Go application in docker
<p>
how we can deploy an application using docker. Without further ado, 
let’s write a simple Golang application for our sample case.</p>

```
  package main

import (
   "net/http"
   "encoding/json"
   "fmt"
)

func main() {
   server := &http.Server{
      Addr:":8888",
   }

   http.HandleFunc("/", hello)

   fmt.Println("Server started on port 8888")
   server.ListenAndServe()
}

func hello(w http.ResponseWriter, _ *http.Request) {
   w.Header().Set("Content-Type", "application/json")

   payload := struct {
      Status  string  `json:"status"`
      Message string  `json:"message"`
   }{
      Status:"Success",
      Message:"Hello world!",
   }

   response, err := json.Marshal(payload)
   if err != nil {
      w.WriteHeader(http.StatusInternalServerError)
      return
   }

   w.Write(response)
} 
```

<p> Now, we can build the app in our local machine and transfer the executable file to our server. 
    Or, we can use docker to build it. </p>

## BUILD

<p>To build using docker, we need to create a Dockerfile inside our project. This file consists a set of 
instructions to build a docker image. In this case, our Dockerfile will be like so. </P>
``` FROM golang
WORKDIR /go/src/github.com/SripadaFusteps/docker_test
ADD . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix .
EXPOSE 8888
ENTRYPOINT ./docker_test ```

<p>So what happened here? First, we set our base image. We can use any docker image as our base, but it’s good to 
use an image that has everything you need to build your application. For example, if you are to build a NodeJS application, 
you might choose nodejs image for your base. Next, we set our WORKDIR which will be used as base path for every command that 
use relative path. Then we ADD all our project files to the docker working directory. With all files already included, now we
can RUN the build command. The EXPOSE command tells docker that the container created by this image will listen to the given port.
Finally, we set the ENTRYPOINT of our container which is the executable produced by the build script.
</p>

```
$ docker build -t golang_test .
$ docker run -d -p 8888:8888 golang_test
```

