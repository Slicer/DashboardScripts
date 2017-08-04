cmake_minimum_required(VERSION 3.9.0)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)
#-----------------------------------------------------------------------------
# Dashboard properties
#-----------------------------------------------------------------------------
set(HOSTNAME              "factory-south-ubuntu")
set(CTEST_DASHBOARD_ROOT  "$ENV{HOME}/Dashboards/Nightly/")

#-----------------------------------------------------------------------------
# Dashboard options
#-----------------------------------------------------------------------------
set(EXTENSIONS_BUILDSYSTEM_TESTING TRUE)
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(CTEST_BUILD_CONFIGURATION "Release")
set(CTEST_BUILD_FLAGS "-j5 -l4") # Use multiple CPU cores to build. For example "-j4 -l3" on unix

#
# Dashboard type
#
set(SCRIPT_MODE "nightly") # "experimental", "continuous", "nightly"

# This will ensure compiler paths specified using the cache variable are used
# consistently.
set(ENV{CC} "/dev/null")
set(ENV{CXX} "/dev/null")

#-----------------------------------------------------------------------------
# Additional CMakeCache options
#-----------------------------------------------------------------------------
set(ADDITIONAL_CMAKECACHE_OPTION "
  CMAKE_C_COMPILER:FILEPATH=/usr/bin/gcc-4.6
  CMAKE_CXX_COMPILER:FILEPATH=/usr/bin/g++-4.6
")

#-----------------------------------------------------------------------------
# Set any extra environment variables here
#-----------------------------------------------------------------------------
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()

#-----------------------------------------------------------------------------
# Git tag
#-----------------------------------------------------------------------------
set(EXTENSIONS_TRACK_QUALIFIER "master") # "master", 4.1, ...
set(EXTENSIONS_INDEX_GIT_TAG "origin/${EXTENSIONS_TRACK_QUALIFIER}") # origin/master, origin/4.1, ...

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicerextensions_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

#-----------------------------------------------------------------------------
# Build Name
#-----------------------------------------------------------------------------
# Update the following variable to match the chosen build options. This variable is used to
# generate both the build directory and the build name.
set(BUILD_OPTIONS_STRING "${MY_BITNESS}bits-QT${MY_QT_VERSION}-NoVTKDebugLeaks")

#-----------------------------------------------------------------------------
# Build directories
#-----------------------------------------------------------------------------
set(dir_suffix ${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE})
set(dir_identifier "0")

set(Slicer_DIR "${CTEST_DASHBOARD_ROOT}/../Nightly/Slicer-${dir_identifier}-build/Slicer-build")

set(testing_suffix "")
if(EXTENSIONS_BUILDSYSTEM_TESTING)
  set(testing_suffix "-Testing")
endif()

#set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/SlicerExtensions-build-${dir_suffix}${testing_suffix}-${EXTENSIONS_TRACK_QUALIFIER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/S-${dir_identifier}-E${testing_suffix}-b")
file(WRITE "${CTEST_DASHBOARD_ROOT}/S-${dir_identifier}-E${testing_suffix}-b - SlicerExtensions-build-${dir_suffix}-${SCRIPT_MODE}${testing_suffix}-${EXTENSIONS_TRACK_QUALIFIER}.txt" "Generated by ${CTEST_SCRIPT_NAME}")

#-----------------------------------------------------------------------------
# Source directories
#-----------------------------------------------------------------------------
set(EXTENSIONS_BUILDSYSTEM_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/../Nightly/Slicer-${dir_identifier}/Extensions/CMake")

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################

set(CTEST_NOTES_FILES "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")

#
# Project specific properties
#
set(CTEST_PROJECT_NAME "Slicer4")
set(CTEST_BUILD_NAME "${MY_OPERATING_SYSTEM}-${MY_COMPILER}-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}")

#
# Download and include dashboard driver script
#
set(url http://svn.slicer.org/Slicer4/trunk/Extensions/CMake/SlicerExtensionsDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
include(${dest})
