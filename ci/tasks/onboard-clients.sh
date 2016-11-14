#!/bin/bash -e
ls -lha
wget -O "pivotal-gemfire.deb" --post-data="" --header="Authorization: Token ${PIVNET_TOKEN}" https://network.pivotal.io/api/v2/products/pivotal-gemfire/releases/2804/product_files/8892/download
sudo dpkg -i pivotal-gemfire.deb

# Loop through Client teams
for team in ./*;
  do
     [ -d $team ] && cd "$team"
     echo Entering into $f
  done;
# Add Security

# Add Jars

# Configure Regions
