PACKAGES=$(shell go list ./...)

all: export GOPATH=${PWD}/../../../..
all: format
	@mkdir -p bin
	@echo "--> Running go build ${VERSION}"
	@go build -v -o bin/docker-volume-glusterfs github.com/21re/docker-volume-glusterfs

format: export GOPATH=${PWD}/../../../..
format:
	@echo "--> Running go fmt"
	@go fmt ./...

cross: bin.linux64 bin.macos

bin.linux64: export GOPATH=${PWD}/../../../..
bin.linux64: export GOOS=linux
bin.linux64: export GOARCH=amd64
bin.linux64:
	@mkdir -p bin
	@echo "--> Running go build for ${GOOS} ${GOARCH}"
	@go build -v -o bin/docker-volume-glusterfs-linux-amd64 github.com/21re/docker-volume-glusterfs

bin.macos: export GOPATH=${PWD}/../../../..
bin.macos: export GOOS=darwin
bin.macos: export GOARCH=amd64
bin.macos:
	@mkdir -p bin
	@echo "--> Running go build for ${GOOS} ${GOARCH}"
	@go build -v -o bin/docker-volume-glusterfs-amd64 github.com/21re/docker-volume-glusterfs

godepssave:
	@echo "--> Godeps save"
	@go get github.com/tools/godep
	@go build -v -o bin/godep github.com/tools/godep
	@bin/godep save ./...
