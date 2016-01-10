# @file example build configuration

#
# Webserver specific
#

# Path of the directory 
# where to build should take place
WEB_DIR='/var/www/html'
BUILD_INFO_DIR='/var/www/build'

# Name of DocumentRoot within $WEB_DIR 
# where the webserver should point to
DOC_ROOT='d7'

#
# Buid process specific
#

# Path to makefile 
BUILD_MAKEFILE='/home/vagrant/build/drupal-org.make'

# Machine name of the profile that should be installed
BUILD_PROFILE='standard'

# Date prefix for build
BUILD_DATE=$(date +%Y%m%d%H%M%S)

# Name pattern for the build
BUILD=${DOC_ROOT}-${BUILD_DATE}

FILE_DIR=${WEB_DIR}/${BUILD}/sites/default/files
BUILD_ROOT=${WEB_DIR}/${BUILD}
CONF=/etc/httpd/conf.d/${BUILD}.conf
WIN_HOSTS=/vagrant_data/etc/hosts

#
# Options for drush site-install
# @see drush help site-install
#

# Specific path to drush version for drush site-install command
DRUSH_SITE_INSTALL_DRUSH='/usr/bin/drush'

# --account-name Option
DRUPAL_UID1='admin'

# --ACCOUNT-PASS OPTION
DRUPAL_UID1_PASS='admin'

# --account-mail
DRUPAL_UID1_MAIL='mail@example.com'

# --site-name Option
DRUPAL_SITE_NAME=${BUILD}

# --site-mail Option
#DRUPAL_SITE_MAIL='mail@example.com'
DRUPAL_SITE_MAIL=${DRUPAL_UID1_MAIL}

#
# Database specific settings to build db_url  
# ${DB_DRIVER}://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB}
#

DB_DRIVER="mysqli"

DB_USER="root"

DB_PASS="root"

DB_HOST="localhost"

DB=${BUILD}

#
# Additional drush make options 
# @see drush help make
#

MAKE_OPTIONS='--nocolor --md5=print --no-patch-txt'

#
# Additional drush site-install (si) options
# @see drush help site-install
#

SI_OPTIONS='--nocolor'
