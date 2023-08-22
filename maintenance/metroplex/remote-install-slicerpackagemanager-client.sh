#!/usr/bin/env bash

set -ex

dashboard_dir=$(cd $(dirname $0) || exit 1; pwd)
source $dashboard_dir/../common/remote_execute.sh

#
# This script installs slicer_package_manager in virtual environments (venv).
#
# The venv are created to enable the use of slicer_package_manager in the following
# contexts:
# (a) the remote system
# (b) the build-env docker images installed on the remote system
#
# It then performs the following tasks on the remote:
#
# (1) create script executed remotely to download "slicer_package_manager" sources
#     in a location reachable from within the build-env docker images
#
# (2) create virtual environments and install slicer_package_manager
#

#------------------------------------------------------------------------------
#
# Download source
#
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)-download-source
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1 || true

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name

#------------------------------------------------------------------------------
# Build-env install(s)
#------------------------------------------------------------------------------

SLICER_PREVIEW_ENV_NAME=qt5-centos7
SLICER_PREVIEW_ENV_VERSION=latest

#------------------------------------------------------------------------------
# Set script properties
#
proj_name="slicer_package_manager"
remote_build_env_root_dir="/home/kitware/Dashboards/Slicer"
remote_support_dir="$remote_build_env_root_dir/Support"

venv_name="${proj_name}-venv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}"
remote_build_env_script=/home/kitware/bin/slicer-buildenv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}

remote_in_build_env_root_dir=/work
remote_in_build_env_support_dir="${remote_in_build_env_root_dir}/Support"
remote_in_build_env_python=/usr/local/bin/python
remote_in_build_env_pip="${remote_in_build_env_support_dir}/${venv_name}/bin/pip"
remote_in_build_env_client="${remote_in_build_env_support_dir}/${venv_name}/bin/slicer_package_manager_client"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}-install
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1 || true

cd $remote_build_env_root_dir

if [[ ! -d ${venv_name} ]]; then
  $remote_build_env_script $remote_in_build_env_python -m venv ${remote_in_build_env_support_dir}/${venv_name}
fi

$remote_build_env_script $remote_in_build_env_pip install --upgrade pip
$remote_build_env_script $remote_in_build_env_pip install --upgrade setuptools
$remote_build_env_script $remote_in_build_env_pip install -U bson girder_client
$remote_build_env_script $remote_in_build_env_pip install -U ${remote_in_build_env_support_dir}/${proj_name}/python_client

# workaround missing _sqlite3 python module
$remote_build_env_script $remote_in_build_env_pip install diskcache
$remote_build_env_script /usr/bin/rm -rf ${remote_in_build_env_support_dir}/${venv_name}/lib/python3.6/site-packages/diskcache
$remote_build_env_script /usr/bin/mkdir ${remote_in_build_env_support_dir}/${venv_name}/lib/python3.6/site-packages/diskcache
$remote_build_env_script /usr/bin/touch  ${remote_in_build_env_support_dir}/${venv_name}/lib/python3.6/site-packages/diskcache/

$remote_build_env_script $remote_in_build_env_client --help

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name

#------------------------------------------------------------------------------
#
# System install
#
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Set script properties
#
venv_name="${proj_name}-venv-system"
remote_python="/home/kitware/.nix-profile/bin/python3.6"
remote_pip="${remote_support_dir}/${venv_name}/bin/pip"
remote_client="${remote_support_dir}/${venv_name}/bin/slicer_package_manager_client"

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)-system-install
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1 || true

cd $remote_support_dir

if [[ ! -d ${venv_name} ]]; then
  ${remote_python} -m venv ${venv_name}
fi

$remote_pip install -U slicer-package-manager-client

$remote_client --help

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name
