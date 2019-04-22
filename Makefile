.PHONY: build clean deploy
# INSPIRATION
# - Serverless Makefile
# - https://gist.github.com/subfuzion/0bd969d08fe0d8b5cc4b23c795854a13 # Closer to hero, but... adding docker versioning (nom nom nom)
# - https://www.youtube.com/watch?v=FiaLKwdv9TI # Not sure how much of this I can use
# Potential GO ENV Vars
# GOARCH="amd64"
	# 386
	# amd64
	# amd64p32
	# arm
	# armbe
	# arm64
	# arm64be
	# ppc64
	# ppc64le
	# mips
	# mipsle
	# mips64
	# mips64le
	# mips64p32
	# mips64p32le
	# ppc
	# s390
	# s390x
	# sparc
	# sparc64
# GOBIN="" # Not configurable by user
# GOCACHE="/Users/dbrummitt/Library/Caches/go-build"
# GOEXE="" # Not configurable by user
# GOFLAGS=""
# GOHOSTARCH="amd64"
# GOHOSTOS="darwin"
# GOOS="darwin"
	# android
	# darwin
	# dragonfly
	# freebsd
	# linux
	# nacl
	# netbsd
	# openbsd
	# plan9
	# solaris
	# windows
	# zos
# GOPATH="/Users/dbrummitt/Development/go"
# GOPROXY=""
# GORACE=""
# GOROOT="/usr/local/Cellar/go/1.11.5/libexec"
# GOTMPDIR=""
# GOTOOLDIR="/usr/local/Cellar/go/1.11.5/libexec/pkg/tool/darwin_amd64"
# GCCGO="gccgo"

# get most recent tag, if none initialze as 0.0.1
SHELL 				:= /bin/bash
TARGET 				:= $(shell echo $${PWD\#\#*/})
VERSION 			:= 0.0.1
BUILD_BRANCH 		:= $(shell git branch | grep \* | cut -d ' ' -f2)
BUILD 				:= $(shell git rev-parse --short HEAD)
BUILD_DATETIME 		:= $(shell echo `date +%Y-%m-%d-%H:%M`)
GOVERSION 			:= $(shell go version | awk '{ print  $$3 }')
#LDFLAGS 			:= -ldflags "-s -w -X=main.BuildTime=$(BUILD_DATETIME) -X=main.BuildVersion=$(VERSION)"
PRODUCTION_RELEASE	:= master
SRC 				:= $(shell find . -type f -name '*.go' -not -path "./vendor/*")
OS 					:= $(shell uname)

build:
	@echo "Building for Mac"
	env GOOS=darwin GOHOSTOS=darwin GOARCH=amd64 go build -o bin/$(TARGET)-mac go-wrk.go
	@echo "Building for Linux"
	env GOOS=linux GOHOSTOS=linux GOARCH=amd64 go build  -o bin/$(TARGET)-linux go-wrk.go

clean:
	rm -rf ./bin

deploy: clean build
