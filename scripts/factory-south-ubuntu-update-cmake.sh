#!/usr/bin/env bash

set -ex

host=10.171.2.142 # factory-south-ubuntu
username=kitware

cmake_xy=3.11
cmake_version=${cmake_xy}.0-rc3

host_working_dir="/home/kitware/Dashboards/Support/"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT > /tmp/$script_name

set -ex

[[ \$(hostname) != "factory-south-ubuntu" ]] && exit 1

cd $host_working_dir

rm -rf cmake-${cmake_version}-Linux-x86_64*

curl -LO "https://cmake.org/files/v${cmake_xy}/cmake-${cmake_version}-Linux-x86_64.tar.gz"
tar -xvf cmake-${cmake_version}-Linux-x86_64.tar.gz
rm cmake-${cmake_version}-Linux-x86_64.tar.gz

./cmake-${cmake_version}-Linux-x86_64/bin/cmake --version

REMOTE_SCRIPT

#------------------------------------------------------------------------------
# Execute script on host
#
ssh $username@$host 'bash -s' < /tmp/$script_name
