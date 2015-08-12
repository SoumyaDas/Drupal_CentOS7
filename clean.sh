#!/bin/bash

# Treat unset variables as an error
set -o nounset

# Source configuration
source $1 || exit 126

##
# Remove old build directory and database 
#
echo "Keeping latest 3 builds!"

# file to get latest build record
FILE=${BUILD_INFO_DIR}/build-record-existing.txt
echo ${BUILD_INFO_DIR}

# file to keep deleted build records
FILE2=${BUILD_INFO_DIR}/build-record-deleted.txt

file_content=( `cat "$FILE" `) || exit 126

number_of_element=${#file_content[@]}

if [ $number_of_element -lt 3 ]
then
  echo "Nothing to clean!"
else
  for((i=0;i<$number_of_element-3;i++)); do 
    echo "Removing database ${file_content[$i]} ...";
    mysql -u ${DB_USER} -p${DB_PASS} -e "drop database \`${file_content[$i]}\`;";
    echo "-- done --";

    echo "Removing build ( ${file_content[$i]} ) directory from the web root ${WEB_DIR}...";
    sudo rm -rf ${WEB_DIR}/${file_content[$i]};
    echo "-- done --";

    sudo sed -i "1d" $FILE
    echo ${file_content[$i]} >> $FILE2
  done
fi

exit 0
