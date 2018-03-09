#!/usr/bin/env bash

set -ex

host=10.171.2.166 # factory-south
username=kitware

cmake_xy=3.11
cmake_version=${cmake_xy}.0-rc3

host_working_dir="/Volumes/Dashboards/Support"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT > /tmp/$script_name

set -ex

[[ \$(hostname) != "factory-south" ]] && exit 1

cd $host_working_dir

rm -rf CMake-${cmake_version}.app cmake-${cmake_version}-Darwin-x86_64*

curl -LO "https://cmake.org/files/v${cmake_xy}/cmake-${cmake_version}-Darwin-x86_64.tar.gz"
tar -xvf cmake-${cmake_version}-Darwin-x86_64.tar.gz

mv cmake-${cmake_version}-Darwin-x86_64/CMake.app CMake-${cmake_version}.app
rm -rf cmake-${cmake_version}-Darwin-x86_64*

./CMake-${cmake_version}.app/Contents/bin/cmake --version

REMOTE_SCRIPT

#------------------------------------------------------------------------------
# Execute script on host
#
ssh $username@$host 'bash -s' < /tmp/$script_name
