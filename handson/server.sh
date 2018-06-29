#!/bin/sh -x

sudo openssl s_server -key key.pem -cert cert.pem -msg -www -accept 443
