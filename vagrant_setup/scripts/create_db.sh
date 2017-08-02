#!/usr/bin/env bash

. /vagrant/vagrant_setup/config.txt

# First, create a database for your project:
sudo su - postgres << EOF

psql -c "
    CREATE DATABASE $APP_DB_NAME;
"

# Next, create a database user for our project. Make sure to select a secure password:

psql -c "
    CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASSWORD';
"

psql -c "
    ALTER ROLE $APP_DB_USER SET client_encoding TO 'utf8';
"

psql -c "
    ALTER ROLE $APP_DB_USER SET default_transaction_isolation TO 'read committed';
"

psql -c "
    ALTER ROLE $APP_DB_USER SET timezone TO 'UTC';
"

# Now, we can give our new user access to administer our new database:
psql -c "
    GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
"

EOF
