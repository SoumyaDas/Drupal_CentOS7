#!/bin/bash

# Treat unset variables as an error
set -o nounset

# Source configuration
source $1 || exit 126

echo -e "${BUILD}"

##
# Needed executables & drush commands
#
DRUSH=$(which drush) &> /dev/null \
  || { echo 'Missing drush. Aborting...' >&2; exit 127; } 

# Specific path to drush version for drush site-install
set +o nounset
[ -z "$DRUSH_SITE_INSTALL_DRUSH" ] && DRUSH_SITE_INSTALL_DRUSH=${DRUSH}
set -o nounset

which git &> /dev/null \
  || { echo 'Missing git. Aborting...'>&2; exit 127; }

drush help make &> /dev/null \
  || { echo "Could not probe 'drush make'. Aborting...">&2; exit 127; }

${DRUSH_SITE_INSTALL_DRUSH} help site-install &> /dev/null \
  || { echo "Could not probe 'drush site-install'. Aborting...">&2; exit 127; }


##
# run drush make
#
cd ${WEB_DIR}
echo -e "# Running drush make, create new build ${BUILD} with ${BUILD_MAKEFILE}...\n"
${DRUSH} make ${MAKE_OPTIONS} ${BUILD_MAKEFILE} ${BUILD} 2>&1 \
  && echo -e "\n# Creating build ${BUILD} was successful\n" \
  || { echo -e "\nFAILED!\n"; exit 1; }

##
# link new build to docroot
#
if [ -L ${DOC_ROOT} ] ; then
  echo -ne "# Symlink ${BUILD} already exists, unlink ${BUILD}... " 
  unlink ${DOC_ROOT} 2>&1 \
    && echo -e "done\n" \
    || { echo -e  "FAILED!\n"; exit 2; }	  
fi
echo -ne "# Symlink ${BUILD} to ${WEB_DIR}/${DOC_ROOT}... "
ln -s ${BUILD} ${DOC_ROOT} 2>&1 \
  && echo -e "done\n" \
  || { echo -e "FAILED!\n"; exit 3; }

##
# run drush site-install (and drop existing tables)
#
echo -e "# Running drush site-install...\n"
${DRUSH_SITE_INSTALL_DRUSH} site-install ${BUILD_PROFILE} ${SI_OPTIONS} -y -r ${WEB_DIR}/${DOC_ROOT} \
 --db-url=${DB_DRIVER}://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB} \
 --account-name=${DRUPAL_UID1} \
 --account-pass=${DRUPAL_UID1_PASS} \
 --account-mail=${DRUPAL_UID1_MAIL} \
 --site-mail=${DRUPAL_SITE_MAIL} \
 --site-name=${DRUPAL_SITE_NAME} 2>&1 \
 && echo -e "\n# Site installation was successful." \
 || { echo -e "\n# FAILED!"; exit 4; }

exit 0 
