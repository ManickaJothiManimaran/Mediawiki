#!/bin/bash

# Install required packages for MediaWiki
dnf module reset php -y
dnf module enable php:7.4 -y 
dnf install httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json wget expect -y

# Start and enable services
systemctl start httpd.service
systemctl enable httpd.service
systemctl start mariadb
systemctl enable mariadb

# Secure the MariaDB installation
MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$MYSQL"

# Create a database and a database user for MediaWiki
mysql -u root --password=$MYSQL -e "CREATE DATABASE my_wiki"
mysql -u root --password=$MYSQL -e "use my_wiki"
mysql -u root --password=$MYSQL -e "CREATE USER 'wikiuser'@'localhost' IDENTIFIED BY 'password';"
mysql -u root --password=$MYSQL -e "GRANT ALL PRIVILEGES ON my_wiki.* TO 'wikiuser'@'localhost' WITH GRANT OPTION;"

# Download and Extract the MediaWiki Files
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.0.tar.gz
mv mediawiki-1.35.0.tar.gz /var/www/html
cd /var/www/html/
tar xvzf mediawiki-1.35.0.tar.gz
mv mediawiki-1.35.0 w

# Set ownership and permissions for the MediaWiki directory
chown -R apache:apache /var/www/html/w

# Create a configuration file for MediaWiki
echo "<?php
\$wgSitename = \"your_domain MediaWiki\";
\$wgMetaNamespace = \"MediaWiki\";
\$wgEnableDebug = false;
\$wgShowExceptionDetails = false;

// Database settings
\$wgDBtype = \"mysql\";
\$wgDBserver = \"localhost\";
\$wgDBuser = \"wikiuser\";
\$wgDBpassword = \"password\";
\$wgDBname = \"my_wiki\";

// Secret key (replace with a random string)
\$wgSecretKey = \"your_secret_key\";

// Enable rewrites for nicer URLs
\$wgUsePathInfo = false;

?>" > /var/www/html/w/LocalSettings.php

# Restart httpd service to apply changes
systemctl restart httpd

# Display completion message
echo "MediaWiki installation complete. Access it at http://your_domain"
