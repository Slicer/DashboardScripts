#!/usr/bin/env bash

dashboard_dir=$(cd $(dirname $0) || exit 1; pwd)
source $dashboard_dir/../common/remote_execute.sh

#------------------------------------------------------------------------------
# Set script properties
#
if [[ $# != 1 ]]; then
  echo "Usage: $0 x.y.z[-rcN]"
  exit 1
fi

cmake_version=$1  # 3.11.0-rc3
echo "cmake_version [${cmake_version}]"

remote_support_dir="/Volumes/D/Support"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1

cd $remote_support_dir

rm -rf CMake-${cmake_version}.app cmake-${cmake_version}-Darwin-x86_64*

curl -LO "https://github.com/Kitware/CMake/releases/download/v${cmake_version}/cmake-${cmake_version}-Darwin-x86_64.tar.gz"
tar -xvf cmake-${cmake_version}-Darwin-x86_64.tar.gz

mv cmake-${cmake_version}-Darwin-x86_64/CMake.app CMake-${cmake_version}.app
rm -rf cmake-${cmake_version}-Darwin-x86_64*

./CMake-${cmake_version}.app/Contents/bin/cmake --version

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name
