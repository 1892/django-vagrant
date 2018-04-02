#!/bin/bash

. /vagrant/vagrant_setup/config.txt

# ------------------------------------------------------------------------------
# If wants create existing project
clear
echo "************************************************************************"
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! DANGER !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "************************************************************************"
echo ""
read -p "Are you sure you want flush entirely DATABASE? (y/n): " dlt_db
if [ "$dlt_db" == y ] ; then

echo "----- PostgreSQL: Delete DB and user"
pg_ctlcluster 9.6 main restart --force

sudo su - postgres << EOF
# -------[script begins]-------
dropdb $APP_DB_NAME

psql -c "
DROP USER $APP_DB_USER;
"

# -------[script ends]-------
EOF



# Database creation
echo "----- PostgreSQL: Creating database and user..."
sudo su - postgres << EOF
# -------[script begins]-------

# psql --help
psql -c "
CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASSWORD';
"
createdb --owner $APP_DB_USER $APP_DB_NAME


# -------[script ends]-------
EOF

fi