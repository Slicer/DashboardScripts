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

x=$(echo $cmake_version | cut -d- -f1 | cut -d. -f1)  # 3 given "3.11.0-rc3"
y=$(echo $cmake_version | cut -d- -f1 | cut -d. -f2)  # 11 given "3.11.0-rc3"
z=$(echo $cmake_version | cut -d- -f1 | cut -d. -f3)  # 0 given "3.11.0-rc3"

# Starting with 3.19.2, "macos-universal" is distributed instead of "Darwin-x86_64"
if [[ $x -ge 3 && $y -ge 19 && $z -ge 2 ]]; then
  cmake_dirname=cmake-${cmake_version}-macos-universal
else
  cmake_dirname=cmake-${cmake_version}-Darwin-x86_64
fi

echo "cmake_dirname [${cmake_dirname}]"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1

cd $remote_support_dir

rm -rf CMake-${cmake_version}.app \$(ls -1 | grep "^${cmake_dirname}")

curl -LO "https://github.com/Kitware/CMake/releases/download/v${cmake_version}/${cmake_dirname}.tar.gz"
tar -xvf ${cmake_dirname}.tar.gz

mv ${cmake_dirname}/CMake.app CMake-${cmake_version}.app
rm -rf \$(ls -1 | grep "^${cmake_dirname}")

./CMake-${cmake_version}.app/Contents/bin/cmake --version

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name
