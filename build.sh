#!/bin/bash

echo "where you want to install: \c"
read build_dir

if [ -z "$build_dir" ]; 
then 
build_dir="${TMPDIR}culturefeed";
echo "create site in $build_dir" 
fi

current_dir=$PWD

rm -Rf $build_dir;
mkdir $build_dir;

cd $build_dir;

drush make -y "${current_dir}/drupal-org-core.make";

mkdir profiles/culturefeed_kickstart;
cp -R "${current_dir}"/* ./profiles/culturefeed_kickstart/;

cd profiles/culturefeed_kickstart;

# The following currently does not work as drupal.org does not allow
# to include modules not hosted on git.drupal.org
#drush make -y --drupal-org=contrib "${current_dir}/drupal-org.make";

drush make -y --no-core "${current_dir}/drupal-org.make";
mv sites/all/* ./
rm -Rf sites

cd $build_dir;

# Copy over composer.json and composer.lock.
cp "${current_dir}/support/composer."* .;

# Install dependencies with composer.
composer install;

printf "\n" >> ./sites/default/default.settings.php
printf "/**\n" >> ./sites/default/default.settings.php
printf " * Include the autoloader generated by Composer.\n" >> ./sites/default/default.settings.php
printf " */\n" >> ./sites/default/default.settings.php
printf "require 'vendor/autoload.php';\n" >> ./sites/default/default.settings.php

cd ${current_dir};

echo "build is available in ${build_dir}.";

exit;