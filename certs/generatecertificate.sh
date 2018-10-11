#!/bin/bash

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./dev.test.key -out ./dev.test.crt -config ./openssl.cnf