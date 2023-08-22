#!/usr/bin/env bash

set -eo pipefail

#-------------------------------------------------------------------------------
PROG=$(basename $0)
script_dir=$(cd $(dirname $0) || exit 1; pwd)

#-------------------------------------------------------------------------------
SLICER_PREVIEW_ENV_NAME=qt5-centos7
SLICER_PREVIEW_ENV_VERSION=latest

venv_name="slicer_package_manager-venv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}"
build_env_script=/home/kitware/bin/slicer-buildenv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}

cd /home/kitware/Dashboards/Slicer

$build_env_script bash /work/DashboardScripts/maintenance/metroplex/clean-nightly-slicer-package-manager.sh -v
