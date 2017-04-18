#!/usr/bin/env bash

export USER=kitware # Required by GitPython so that call to "os.getlogin()/getpass.getuser()" works.
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=/usr/local/git/bin/:$PATH

DASHBOARD_DIR=/home/kitware/Dashboards
SLICER_WIKI_SCRIPTS_DIR=$DASHBOARD_DIR/Support/slicer-wiki-scripts

# Clone
[[ ! -d $SLICER_WIKI_SCRIPTS_DIR ]] && git clone git://github.com/Slicer/slicer-wiki-scripts $SLICER_WIKI_SCRIPTS_DIR

pushd $SLICER_WIKI_SCRIPTS_DIR

# Update discarding local changes
git reset --hard && git checkout master && git fetch origin && git reset --hard origin/master

#
# We will use the release python interpreter to update the wiki for both
# the Release and the Nightly namespace

PACKAGE_VERSION=462
SLICER_BUILD_DIR=$DASHBOARD_DIR/Package/Slicer-$PACKAGE_VERSION-package/Slicer-build
SLICER_PYTHON="$SLICER_BUILD_DIR/Slicer --launch python"

source ~/Dashboards/Support/Slicer-WikiCredential.sh

#
# Release
#
$SLICER_PYTHON slicer_wiki_extension_module_listing.py update-wiki --slicer-version "Slicer 4.4" $SLICER_BUILD_DIR $SLICERBOT_PASSWORD

#
# Nightly
#
$SLICER_PYTHON slicer_wiki_extension_module_listing.py update-wiki --slicer-version "Slicer 4.4-Nightly" $SLICER_BUILD_DIR $SLICERBOT_PASSWORD

popd

