#!/bin/bash

PROXY_PRIVATE_KEY=${PROXY_PRIVATE_KEY:-"/etc/ssl/private_keys/foreman.pem"}
PROXY_CERT=${PROXY_CERT:-"/etc/ssl/certs/foreman.pem"}
PROXY_CA_CERT=${PROXY_CA_CERT:-"/etc/ssl/certs/foreman-ca.pem"}
PROXY_HOSTNAME=${PROXY_HOSTNAME:-"foreman.local"}

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-puppet \
  --enable-foreman-proxy \
  --foreman-proxy-register-in-foreman=false $PROXY_ARGS
