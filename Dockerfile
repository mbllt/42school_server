FROM debian:buster

ENV PORT 80

RUN apt-get update -y && apt-get install -y \
	nginx \
	vim

ENTRYPOINT /bin/bash

CMD service nginx start
