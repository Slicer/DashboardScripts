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
# Release
#
PACKAGE_VERSION=440
SLICER_BUILD_DIR=$DASHBOARD_DIR/Package/Slicer-$PACKAGE_VERSION-package/Slicer-build
SLICER_EXTENSIONS_INDEX_BUILD_DIR=$DASHBOARD_DIR/Nightly/S-$PACKAGE_VERSION-E-b

$SLICER_BUILD_DIR/Slicer --launch python slicer_wiki_extension_module_listing.py publish-extension-module-metadata $SLICER_BUILD_DIR $SLICER_EXTENSIONS_INDEX_BUILD_DIR

#
# Nightly
#
DIRECTORY_IDENTIFIER=0
SLICER_BUILD_DIR=$DASHBOARD_DIR/Nightly/Slicer-$DIRECTORY_IDENTIFIER-build/Slicer-build
SLICER_EXTENSIONS_INDEX_BUILD_DIR=$DASHBOARD_DIR/Nightly/S-$DIRECTORY_IDENTIFIER-E-b

if [[ -f $SLICER_BUILD_DIR/Slicer ]]
then
  $SLICER_BUILD_DIR/Slicer --launch python slicer_wiki_extension_module_listing.py publish-extension-module-metadata $SLICER_BUILD_DIR $SLICER_EXTENSIONS_INDEX_BUILD_DIR
else
  echo "Skipping 'publish-extension-module-metadata': $SLICER_BUILD_DIR/Slicer does NOT exists"
fi

popd
