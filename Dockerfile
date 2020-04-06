FROM golang:1.14-alpine

COPY . /build

RUN apk --no-cache add py3-pip make git zip && \
    pip3 --no-cache-dir install cloudformation-cli-go-plugin &&\
    cd /build &&\
    #go get k8s.io/client-go@v0.15.11 github.com/googleapis/gnostic@v0.3.1 ./...
    go mod tidy

CMD cd /build && \
    make -f Makefile.package package &&\
    mv /build/awsqs-eks-cluster.zip /output/
