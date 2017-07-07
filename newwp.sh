#!/bin/bash

open -a Docker
docker stop $(docker ps -a -q)

cd ~/Documents/BBC
printf "Gitlab Repo URL: "
read REPO
printf "Local repo folder name: "
read NEWDIR
git clone $REPO $NEWDIR
cd $NEWDIR
git submodule add git@github.com:brainbytes/docker-compose-wordpress.git
cd docker-compose-wordpress
docker-compose up -d
echo "Installing WP Core at localhost:8000. This could take 20 seconds. "
printf '|                       |  (0%%)\r'
printf '|=                      |  (5%%)\r'
sleep 1
printf '|==                     |  (10%%)\r'
sleep 2
printf '|===                    |  (15%%)\r'
printf '|====                   |  (20%%)\r'
sleep 4
printf '|=====                  |  (25%%)\r'
sleep 4
printf '|==========             |  (50%%)\r'
sleep 3
printf '|================       |  (75%%)\r'
sleep 3
printf '|==================     |  (85%%)\r'
sleep 3
printf '|====================   |  (100%%)\r'
docker exec dockercomposewordpress_wordpress_1 wp core install --url=localhost:8000 --title=wordpress --admin_name=admin --admin_email=graham@brainbytescreative.com --admin_password=admin
echo "================================================================="
echo "Installation is complete. Your username/password is listed below."
echo ""
echo "Username: admin"
echo "Password: admin"
echo ""
echo "================================================================="

# Import Database
# while true; do
#     echo "Do you wish to import a .sql file?"
#     read -p "y or n: " yn
#     case $yn in
#         [Yy]* ) printf "What is the path to your .sql file? "; read dbimportpath; echo $dbimportpath; docker exec dockercomposewordpress_wordpress_1 wp db import $dbimportpath;;
#         [Nn]* ) exit;;
#         * ) echo "Please answer yes or no.";;
#     esac
# done

# wp search-replace old-site.com new-site.dev # --test-run

# Open localhost
# while true; do
#     echo "Do you wish to open localhost:8000 in the browser?"
#     read -p "y or n: " yn
#     case $yn in
#         [Yy]* ) open http://localhost:8000/wp-admin; break;;
#         [Nn]* ) exit;;
#         * ) echo "Please answer yes or no.";;
#     esac
# done

