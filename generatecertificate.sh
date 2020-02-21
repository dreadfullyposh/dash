#!/bin/bash

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./localtest.me.key -out ./localtest.me.crt -config ./openssl.cnf