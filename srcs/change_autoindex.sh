#!/bin/bash

if [ "$AUTOINDEX" = "OFF" ] ; then
	cat autoindex_off > /etc/nginx/sites-available/default
elif [ "$AUTOINDEX" = "ON" ] ; then
	cat autoindex_on > /etc/nginx/sites-available/default
fi
service nginx restart
