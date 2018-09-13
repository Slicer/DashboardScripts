#!/usr/bin/env bash

set -ex

dashboard_dir=$(cd $(dirname $0) || exit 1; pwd)
source $dashboard_dir/../common/remote_execute.sh

#------------------------------------------------------------------------------
# Set script properties
#
remote_support_dir="/Volumes/Dashboards/Support"

proj_name="slicer_package_manager"
venv_name="${proj_name}-venv"
remote_python="/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6"
remote_pip="${remote_support_dir}/${venv_name}/bin/pip"
remote_client="${remote_support_dir}/${venv_name}/bin/slicer_package_manager_client"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1

cd $remote_support_dir

if [[ ! -d ${proj_name} ]]; then
  git clone git://github.com/girder/slicer_package_manager ${proj_name}
fi

pushd ${proj_name}
git fetch origin
git reset --hard origin/master
popd


if [[ ! -d ${venv_name} ]]; then
  ${remote_python} -m venv ${venv_name}
fi

$remote_pip install -U bson girder_client
$remote_pip install -U ${remote_support_dir}/${proj_name}/python_client

$remote_client --help

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name