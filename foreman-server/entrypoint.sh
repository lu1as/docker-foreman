#!/bin/bash

set -e

export SEED_ADMIN_USER=${FOREMAN_ADMIN_USER:-admin}
export SEED_ADMIN_PASSWORD=${FOREMAN_ADMIN_PASSWORD:-changeme}

# replace environment variables in config files
sed -i "s/##REDIS_URL##/${REDIS_URL//\//\\/}/g" /etc/foreman/settings.yaml
sed -i "s/##POSTGRES_HOST##/$POSTGRES_HOST/g" /etc/foreman/database.yml
sed -i "s/##POSTGRES_DATABASE##/$POSTGRES_DATABASE/g" /etc/foreman/database.yml
sed -i "s/##POSTGRES_USERNAME##/$POSTGRES_USERNAME/g" /etc/foreman/database.yml
sed -i "s/##POSTGRES_PASSWORD##/$POSTGRES_PASSWORD/g" /etc/foreman/database.yml
sed -i "s/##ENCRYPTION_KEY##/$ENCRYPTION_KEY/g" /etc/foreman/encryption_key.rb

echo "Foreman::Application.config.secret_key_base = '$SECRET_TOKEN'" > /usr/share/foreman/config/initializers/local_secret_token.rb

# add settings from environment (use prefix: FOREMAN_SETTINGS_)
for setting in "${!FOREMAN_SETTINGS_@}"; do
    name=${setting#FOREMAN_SETTINGS_}
    printf 'set %s: %s\n' "${name,,}" "${!setting}"
    echo ":${name,,}: ${!setting}" >> /etc/foreman/settings.yaml
done

# check for new CA certificates and import them
if [ ! -z "$(ls -A /etc/pki/ca-trust/source/anchors)" ]; then
    sudo update-ca-trust
fi

# migrate database
/usr/share/foreman/extras/dbmigrate

FOREMAN_ENV=production
FOREMAN_PORT=3000
FOREMAN_BIND=0.0.0.0

/usr/bin/scl enable tfm "rails server --environment $FOREMAN_ENV --port $FOREMAN_PORT --binding $FOREMAN_BIND"
