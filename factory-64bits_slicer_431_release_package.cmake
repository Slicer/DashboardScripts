cmake_minimum_required(VERSION 2.8.8)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)

#
# Dashboard properties
#
set(HOSTNAME              "factory")
set(CTEST_DASHBOARD_ROOT  "$ENV{HOME}/Dashboards/Package")

set(package_version 431)
set(SVN_BRANCH "branches/Slicer-4-3")
set(SVN_REVISION "22599") # Release 4.3.1

#
# Dashboard options
#
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(CTEST_BUILD_CONFIGURATION "Release")
set(WITH_PACKAGES TRUE)
set(WITH_EXTENSIONS FALSE) # Indicates if 'trusted' Slicer extensions should be
                          # built, tested, packaged and uploaded.
set(CTEST_BUILD_FLAGS "-j9 -l8") # Use multiple CPU cores to build. For example "-j4 -l3" on unix

set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicer_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

set(SCRIPT_MODE "experimental") # "experimental", "continuous", "nightly"

# You could invoke the script with the following syntax:
#  ctest -S karakoram_Slicer4_nightly.cmake -V

#
# Additional CMakeCache options
#
set(ADDITIONAL_CMAKECACHE_OPTION "
  ADDITIONAL_C_FLAGS:STRING=
  ADDITIONAL_CXX_FLAGS:STRING=
  Slicer_USE_VTK_DEBUG_LEAKS:BOOL=OFF
  Slicer_BUILD_CLI:BOOL=ON
  Slicer_USE_SimpleITK:BOOL=ON
  Slicer_USE_PYTHONQT_WITH_OPENSSL:BOOL=ON
")

set(BUILD_OPTIONS_STRING "${MY_BITNESS}bits")

#
# Project specific properties
#
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer-${package_version}")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer-${package_version}-package")

# List of test that should be explicitly disabled on this machine
set(TEST_TO_EXCLUDE_REGEX "qMRMLLayoutManagerTest3")

# set any extra environment variables here
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()


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
# Display build info
#
message("site name: ${CTEST_SITE}")
message("build name: ${CTEST_BUILD_NAME}")
message("script mode: ${SCRIPT_MODE}")
message("coverage: ${WITH_COVERAGE}, memcheck: ${WITH_MEMCHECK}")

#
# Download and include dashboard driver script 
#
set(url http://svn.slicer.org/Slicer4/${SVN_BRANCH}/CMake/SlicerDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
INCLUDE(${dest})

