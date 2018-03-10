#!/usr/bin/env bash

set -ex

script_dir=$(cd $(dirname $0) || exit 1; pwd)

remote_ip=$(head -n1 $script_dir/IP)
remote_username=$(head -n1 $script_dir/USERNAME)

remote_working_dir="/Volumes/Dashboards/Support"

proj_name="slicer_package_manager"
venv_name="${proj_name}-venv"
remote_python="/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6"
remote_pip="${remote_working_dir}/${venv_name}/bin/pip"
remote_client="${remote_working_dir}/${venv_name}/bin/slicer_package_manager_client"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT > /tmp/$script_name

set -ex

[[ \$(hostname) != "factory-south" ]] && exit 1

cd $remote_working_dir

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
$remote_pip install -U ${remote_working_dir}/${proj_name}/python_client

$remote_client --help

REMOTE_SCRIPT

#------------------------------------------------------------------------------
# Execute script on remote
#
ssh $remote_username@$remote_ip 'bash -s' < /tmp/$script_name
