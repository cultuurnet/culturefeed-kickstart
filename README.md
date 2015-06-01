culturefeed-kickstart
=====================

Drupal installation profile with culturefeed 3.x branche

Prerequisites

- full LAMP stack
- git installed
- drush installed
- composer installed (http://getcomposer.org/doc/00-intro.md#downloading-the-composer-executable)

To build your site just run 'sh build.sh' in the root of the culturefeed-kickstart project. 

On new servers make sure unzip is installed (for drush make) and gd, curl and mod_rewrite  (for drupal)
- sudo apt-get install unzip
- sudo apt-get install php5-gd
- sudo apt-get install php5-curl
- sudo a2enmod rewrite


To make correct OAuth requests make sure date (date) and timezone is correct
- sudo dpkg-reconfigure tzdata

To install the profile, run the following command from the drupal root:

	drush site-install culturefeed_kickstart --account-mail=yourAdmin@email --account-name=adminUsername --account-pass=adminPassword --site-name=CFKickStart --site-mail=yourSite@email --locale=ISOCode --db-url=mysql://dbUsername:dbPassword@localhost/dbName -y
		
Be sure to replace all values with your own values.
