#!/usr/bin/env bash

set -ex

script_dir=$(cd $(dirname $0) || exit 1; pwd)

remote_ip=$(head -n1 $script_dir/IP)
remote_username=$(head -n1 $script_dir/USERNAME)

if [[ $# != 1 ]]; then
  echo "Usage: $0 x.y.z[-rcN]"
  exit 1
fi

cmake_version=$1  # 3.11.0-rc3

cmake_x=$(echo $cmake_version | cut -d"." -f1)
cmake_y=$(echo $cmake_version | cut -d"." -f2)
cmake_xy=${cmake_x}.${cmake_y}  # 3.11

echo "cmake_xy      [${cmake_xy}]"
echo "cmake_version [${cmake_version}]"

remote_working_dir="/home/kitware/Dashboards/Support/"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT > /tmp/$script_name

set -ex

[[ \$(hostname) != "factory-south-ubuntu" ]] && exit 1

cd $remote_working_dir

rm -rf cmake-${cmake_version}-Linux-x86_64*

curl -LO "https://cmake.org/files/v${cmake_xy}/cmake-${cmake_version}-Linux-x86_64.tar.gz"
tar -xvf cmake-${cmake_version}-Linux-x86_64.tar.gz
rm cmake-${cmake_version}-Linux-x86_64.tar.gz

./cmake-${cmake_version}-Linux-x86_64/bin/cmake --version

REMOTE_SCRIPT

#------------------------------------------------------------------------------
# Execute script on remote
#
ssh $remote_username@$remote_ip 'bash -s' < /tmp/$script_name
