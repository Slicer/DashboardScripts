#!/usr/bin/env bash

set -ex

dashboard_dir=$(cd $(dirname $0) || exit 1; pwd)
source $dashboard_dir/../common/remote_execute.sh

#------------------------------------------------------------------------------
# Set script properties
#
remote_support_dir="/home/kitware/Support"

proj_name="girder_client"
venv_name="${proj_name}-venv"
remote_python="/home/kitware/.nix-profile/bin/python3.5"
remote_pip="${remote_support_dir}/${venv_name}/bin/pip"
remote_client="${remote_support_dir}/${venv_name}/bin/girder-cli"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1 || true

cd $remote_support_dir

if [[ ! -d ${venv_name} ]]; then
  ${remote_python} -m venv ${venv_name}
fi

$remote_pip install -U girder_client

$remote_client --help

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name
