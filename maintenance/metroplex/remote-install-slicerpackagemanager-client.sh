#!/usr/bin/env bash

set -ex

dashboard_dir=$(cd $(dirname $0) || exit 1; pwd)
source $dashboard_dir/../common/remote_execute.sh

#
# This script installs slicer_package_manager in virtual environments (venv).
#
# The venv are created to enable the use of slicer_package_manager in the following
# contexts:
# * the build-env docker images installed on the remote system
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
# Build-env install(s)
#
#------------------------------------------------------------------------------

SLICER_PREVIEW_ENV_NAME=${SLICER_PREVIEW_ENV_NAME:-qt5-almalinux8-gcc14}
SLICER_PREVIEW_ENV_VERSION=${SLICER_PREVIEW_ENV_VERSION:-latest}

#------------------------------------------------------------------------------
# Set script properties
#
proj_name="slicer_package_manager"
remote_build_env_root_dir="/home/svc-dashboard/Dashboards/Slicer"
remote_support_dir="$remote_build_env_root_dir/Support"

venv_name="${proj_name}-venv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}"
remote_build_env_script=/home/svc-dashboard/bin/slicer-buildenv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}

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

if [[ ! -d ${remote_support_dir}/${venv_name} ]]; then
  $remote_build_env_script $remote_in_build_env_python -m venv ${remote_in_build_env_support_dir}/${venv_name}
fi

$remote_build_env_script $remote_in_build_env_pip install --upgrade pip
$remote_build_env_script $remote_in_build_env_pip install -U setuptools slicer-package-manager-client

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

# As of August 2023, support for using the client directly on the host is not available anymore.
