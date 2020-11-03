#!/bin/bash


#export CF_TOKEN=SPECIFY
#export CF_USER=SPECIFY
#export CF_DOMAIN=SPECIFY
#export CONFLUENCE_SPACE=SPECIFY
#export CONFLUENCE_API_URL=${CF_DOMAIN}/rest/api/
#export CONFLUENCE_USERNAME=${CF_USER}
#export CONFLUENCE_PASSWORD=${CF_TOKEN}

declare -a dirs=("docs" )

for d in ${dirs[@]}; do

(
cd $d
for file in $(find -maxdepth 1 -type f -name '*.md'); do
  echo "> Sync $file";
#  echo mark -u $CF_USER -p $CF_TOKEN -b $CF_DOMAIN -f $file
  mark -u $CF_USER -p $CF_TOKEN -b $CF_DOMAIN -f $file || exit 1;
  echo;
done
)

done


