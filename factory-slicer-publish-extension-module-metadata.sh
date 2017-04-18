#!/usr/bin/env bash

export USER=kitware # Required by GitPython so that call to "os.getlogin()/getpass.getuser()" works.
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

DASHBOARD_DIR=/Users/kitware/Dashboards
SLICER_WIKI_SCRIPTS_DIR=$DASHBOARD_DIR/Support/slicer-wiki-scripts

# Clone
[[ ! -d $SLICER_WIKI_SCRIPTS_DIR ]] && git clone git://github.com/Slicer/slicer-wiki-scripts $SLICER_WIKI_SCRIPTS_DIR

pushd $SLICER_WIKI_SCRIPTS_DIR

# Update discarding local changes
git reset --hard && git checkout master && git fetch origin && git reset --hard origin/master

#
# Release
#
PACKAGE_VERSION=462
SLICER_BUILD_DIR=$DASHBOARD_DIR/Package/Slicer-$PACKAGE_VERSION-package/Slicer-build
SLICER_EXTENSIONS_INDEX_BUILD_DIR=$DASHBOARD_DIR/Nightly/S-$PACKAGE_VERSION-E-b
SLICER_PYTHON_EXE=$SLICER_BUILD_DIR/../python-install/bin/python

#$SLICER_BUILD_DIR/Slicer --launch $SLICER_PYTHON_EXE slicer_wiki_extension_module_listing.py publish-extension-module-metadata $SLICER_BUILD_DIR $SLICER_EXTENSIONS_INDEX_BUILD_DIR

#
# Nightly
#
DIRECTORY_IDENTIFIER=0
SLICER_BUILD_DIR=$DASHBOARD_DIR/Nightly/Slicer-$DIRECTORY_IDENTIFIER-build/Slicer-build
SLICER_EXTENSIONS_INDEX_BUILD_DIR=$DASHBOARD_DIR/Nightly/S-$DIRECTORY_IDENTIFIER-E-b
SLICER_PYTHON_EXE=$SLICER_BUILD_DIR/../python-install/bin/python

if [[ -f $SLICER_BUILD_DIR/Slicer ]]
then
  $SLICER_BUILD_DIR/Slicer --launch $SLICER_PYTHON_EXE slicer_wiki_extension_module_listing.py publish-extension-module-metadata $SLICER_BUILD_DIR $SLICER_EXTENSIONS_INDEX_BUILD_DIR
else
  echo "Skipping 'publish-extension-module-metadata': $SLICER_BUILD_DIR/Slicer does NOT exists"
fi

popd
