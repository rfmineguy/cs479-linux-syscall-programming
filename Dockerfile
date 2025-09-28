from ubuntu:latest
env CONTAINER=docker

workdir /home/build
run apt update
run apt install -y build-essential make
