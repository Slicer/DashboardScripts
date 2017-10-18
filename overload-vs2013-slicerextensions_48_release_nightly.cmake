cmake_minimum_required(VERSION 3.9.0)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)
#-----------------------------------------------------------------------------
# Dashboard properties
#-----------------------------------------------------------------------------
set(HOSTNAME              "overload")
set(MY_COMPILER           "VS2013")
set(CTEST_DASHBOARD_ROOT  "D:/D/N")
# Open a shell and type in "cmake --help" to obtain the proper spelling of the generator
set(CTEST_CMAKE_GENERATOR "Visual Studio 12 2013 Win64")
set(MY_BITNESS            "64")

set(EXTENSIONS_TRACK_QUALIFIER "4.8") # "master", 4.1, ...
set(SVN_BRANCH "trunk") # trunk or branches/Slicer-4.8
set(package_version "480")

#-----------------------------------------------------------------------------
# Dashboard options
#-----------------------------------------------------------------------------
set(EXTENSIONS_BUILDSYSTEM_TESTING FALSE)
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(CTEST_BUILD_CONFIGURATION "Release")
set(CTEST_BUILD_FLAGS "") # Use multiple CPU cores to build. For example "-j -l4" on unix

#
# Dashboard type
#
set(SCRIPT_MODE "nightly") # "experimental", "continuous", "nightly"

#-----------------------------------------------------------------------------
# Additional CMakeCache options
#-----------------------------------------------------------------------------
set(ADDITIONAL_CMAKECACHE_OPTION "
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

#set(Slicer_DIR "${CTEST_DASHBOARD_ROOT}/Slicer-${package_version}-build-${dir_suffix}/Slicer-build")
set(Slicer_DIR "${CTEST_DASHBOARD_ROOT}/../P/Slicer-${package_version}-package/Slicer-build")

set(testing_suffix "")
if(EXTENSIONS_BUILDSYSTEM_TESTING)
  set(testing_suffix "-T")
endif()

#set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/SlicerExtensions-${package_version}-build-${dir_suffix}${testing_suffix}-${EXTENSIONS_TRACK_QUALIFIER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/S${package_version}-E${testing_suffix}-b")
file(WRITE "${CTEST_DASHBOARD_ROOT}/S${package_version}-E${testing_suffix}-b - SlicerExtensions-${package_version}-build-${dir_suffix}${testing_suffix}-${EXTENSIONS_TRACK_QUALIFIER}.txt" "Generated by ${CTEST_SCRIPT_NAME}")

#-----------------------------------------------------------------------------
# Source directories
#-----------------------------------------------------------------------------
set(EXTENSIONS_BUILDSYSTEM_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/../P/Slicer-${package_version}/Extensions/CMake")

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
set(url http://svn.slicer.org/Slicer4/${SVN_BRANCH}/Extensions/CMake/SlicerExtensionsDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
include(${dest})
