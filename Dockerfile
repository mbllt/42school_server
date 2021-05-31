FROM debian:buster

ENV PORT 80

RUN apt-get update

RUN apt-get -y upgrade

RUN apt-get -y install wget

RUN apt-get -y install nginx

# -y pour repondre yes en avance