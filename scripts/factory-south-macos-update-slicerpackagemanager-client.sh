#!/usr/bin/env bash

set -ex

host=10.171.2.166 # factory-south
username=kitware

host_working_dir="/Volumes/Dashboards/Support"

proj_name="slicer_package_manager"
venv_name="${proj_name}-venv"
host_python="/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6"
host_pip="${host_working_dir}/${venv_name}/bin/pip"
host_client="${host_working_dir}/${venv_name}/bin/slicer_package_manager_client"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT > /tmp/$script_name

set -ex

[[ \$(hostname) != "factory-south" ]] && exit 1

cd $host_working_dir

if [[ ! -d ${proj_name} ]]; then
  git clone git://github.com/girder/slicer_package_manager ${proj_name}
fi

pushd ${proj_name}
git fetch origin
git reset --hard origin/master
popd


if [[ ! -d ${venv_name} ]]; then
  ${host_python} -m venv ${venv_name}
fi

$host_pip install -U bson girder_client
$host_pip install -U ${host_working_dir}/${proj_name}/python_client

$host_client --help

REMOTE_SCRIPT

#------------------------------------------------------------------------------
# Execute script on host
#
ssh $username@$host 'bash -s' < /tmp/$script_name
