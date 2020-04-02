#!/bin/bash

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./certs/localtest.me.key -out ./certs/localtest.me.crt -config ./openssl.cnf
