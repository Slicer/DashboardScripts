#!/usr/bin/env bash

set -e

script_dir=$(cd $(dirname $0) || exit 1; pwd)

if [[ $# != 2 ]]; then
  echo "Usage: $0 <dashboard-name> <to-cmake-version>"
  exit 1
fi

dashboard_name=$1
to_cmake_version=$2

root_dir=$script_dir/../..

echo "    dashboard_name [$dashboard_name]"
echo "  to_cmake_version [$to_cmake_version]"
echo "          root_dir [$root_dir]"

script_sh=$root_dir/$dashboard_name.sh
script_bat=$root_dir/$dashboard_name.bat

echo "         script_sh [$script_sh]"
echo "        script_bat [$script_bat]"

if [[ -f $script_sh ]]; then
  script=$script_sh
elif [[ -f $script_bat ]]; then
  script=$script_bat
else
  echo "Missing nightly script for dashboard [$dashboard_name]"
  exit 1
fi

from_cmake_version=$(cat $script| grep "CMAKE_VERSION=" | sed -e "s/\s+/ /" | tr -s " " | cut -d" " -f2 | cut -d"=" -f2)
[[ -z "$from_cmake_version" ]] && (echo "Failed to extract from_cmake_version"; exit 1)
echo "from_cmake_version [$from_cmake_version]"

echo "Updating $script"
sed -i -e "s/CMAKE_VERSION=$from_cmake_version/CMAKE_VERSION=$to_cmake_version/g" $script
sed -i -e "s/cmake-$from_cmake_version/cmake-$to_cmake_version/g" $script
sed -i -e "s/CMake-$from_cmake_version/CMake-$to_cmake_version/g" $script

