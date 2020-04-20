FROM golang:1.14-alpine

RUN apk --no-cache add py3-pip make git zip

RUN pip3 --no-cache-dir install cloudformation-cli-go-plugin

COPY . /build

WORKDIR /build

RUN GOPROXY=direct go mod tidy

RUN make -f Makefile.package package

CMD mkdir -p /output/ && mv /build/awsqs-eks-cluster.zip /output/
