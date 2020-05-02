#!/bin/bash

SERVER_PRIVATE_KEY=${SERVER_PRIVATE_KEY:-"/etc/ssl/private_keys/foreman.pem"}
SERVER_CERT=${SERVER_CERT:-"/etc/ssl/certs/foreman.pem"}
SERVER_CA_CERT=${SERVER_CA_CERT:-"/etc/ssl/certs/foreman-ca.pem"}
SERVER_HOSTNAME=${SERVER_HOSTNAME:-"foreman.local"}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-"changeme"}

foreman-installer \
    --no-enable-puppet \
    --puppet-agent=false \
    --puppet-server=false \
    --foreman-server-ssl-crl="" \
    --foreman-server-ssl-key=$SERVER_PRIVATE_KEY \
    --foreman-server-ssl-cert=$SERVER_CERT \
    --foreman-server-ssl-chain=$SERVER_CA_CERT \
    --foreman-server-ssl-ca=$SERVER_CA_CERT \
    --foreman-client-ssl-key=$SERVER_PRIVATE_KEY \
    --foreman-client-ssl-cert=$SERVER_CERT \
    --foreman-client-ssl-ca=$SERVER_CA_CERT \
    --foreman-initial-admin-password=$ADMIN_PASSWORD \
    --no-enable-foreman-proxy \
    --enable-foreman-compute-libvirt \
    --foreman-foreman-url=https://$SERVER_HOSTNAME \
    --foreman-db-manage=false \
    --foreman-db-host=$DB_HOST \
    --foreman-db-database=$DB_DATABASE \
    --foreman-db-username=$DB_USERNAME \
    --foreman-db-password=$DB_PASSWORD \
    --foreman-jobs-sidekiq-redis-url=$REDIS_URL $SERVER_ARGS

# foreman-rake db:migrate
# foreman-rake db:seed
# foreman-rake apipie:cache:index
