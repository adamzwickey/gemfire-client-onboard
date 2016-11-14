#!/bin/bash -e

wget -O "pivotal-gemfire.deb" --post-data="" --header="Authorization: Token ${PIVNET_TOKEN}" https://network.pivotal.io/api/v2/products/pivotal-gemfire/releases/2804/product_files/8892/download
sudo dpkg -i pivotal-gemfire.deb

ls -lha

# Loop through Client teams
find . -maxdepth 1 -type d \( ! -name . \) | while read d; do
  if [[ $d == *"ci"* || $d == *".git"* ]]; then
    continue
  fi

  echo Entering into $d
  cd $d
  # Add Security

  # Add Jars
  for jar in ./jars/*.jar; do
    #Execute GFSH Command to load jars
    echo "Loading Jar [$jar] into Gemfire"
    gfsh \
    -e "connect --locator=${LOCATOR_CONNECTION}" \
    -e "deploy --jar=$jar"
  done;

  # Configure Regions

  echo Done Onboading $d
done;
