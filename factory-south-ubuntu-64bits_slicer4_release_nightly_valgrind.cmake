cmake_minimum_required(VERSION 2.8.2)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)

#
# Dashboard properties
#
set(HOSTNAME              "factory-south-ubuntu")
set(CTEST_DASHBOARD_ROOT  "$ENV{HOME}/Dashboards/Nightly/")

set(CTEST_MEMORYCHECK_SUPPRESSIONS_FILE "${CTEST_SCRIPT_DIRECTORY}/${HOSTNAME}-ubuntu_slicer4_valgrind_supression.txt")
set(CTEST_MEMORYCHECK_COMMAND_OPTIONS "--gen-suppressions=all --trace-children=yes -q --leak-check=yes --show-reachable=yes --num-callers=100")

#
# Dashboard options
#
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK TRUE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(WITH_PACKAGES OFF)
set(CTEST_BUILD_CONFIGURATION "Release")
set(CTEST_BUILD_FLAGS "-j9") # Use multiple CPU cores to build. For example "-j4" on unix

set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicer_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

set(SCRIPT_MODE "nightly") # "experimental", "continuous", "nightly"

# You could invoke the script with the following syntax:
#  ctest -S karakoram_Slicer4_nightly.cmake -V

#
# Additional CMakeCache options
#
set(ADDITIONAL_CMAKECACHE_OPTION "
  GIT_EXECUTABLE:FILEPATH=/home/kitware/Dashboards/Support/git-1.7.3.4/git
  MEMORYCHECK_COMMAND:FILEPATH=${CTEST_MEMORYCHECK_COMMAND}
  MEMORYCHECK_SUPPRESSIONS_FILE:FILEPATH=${CTEST_MEMORYCHECK_SUPPRESSIONS_FILE}
  MEMORYCHECK_COMMAND_OPTIONS:STRING=${CTEST_MEMORYCHECK_COMMAND_OPTIONS}
")

set(BUILD_OPTIONS_STRING "PythonQt-With-Tcl-CLI-Valgrind") 

#
# Project specific properties
#
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer4")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer-build-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE}")

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
set(CTEST_BUILD_NAME "${MY_OPERATING_SYSTEM}-${MY_COMPILER}-QT${MY_QT_VERSION}-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}")

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
set(url http://svn.slicer.org/Slicer4/trunk/CMake/SlicerDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
INCLUDE(${dest})
