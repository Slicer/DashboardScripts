cmake_minimum_required(VERSION 3.9.0)

#
# For additional information, see http://www.slicer.org/slicerWiki/index.php/Documentation/Nightly/Developers/Tutorials/DashboardSetup
#

#-----------------------------------------------------------------------------
# Experimental:
#     - run_ctest() macro will be called *ONE* time
#     - binary directory will *NOT* be cleaned
# Continuous:
#     - run_ctest() macro will be called EVERY 5 minutes ...
#     - binary directory will *NOT* be cleaned
#     - configure/build will be executed *ONLY* if the repository has been updated
# Nightly:
#     - run_ctest() macro will be called *ONE* time
#     - binary directory *WILL BE* cleaned
set(SCRIPT_MODE "Experimental") # "Experimental", "Continuous", "Nightly"

# You could invoke the script with the following syntax:
#  ctest -S karakoram_Slicer4_nightly.cmake -C <CTEST_BUILD_CONFIGURATION> -V
#
# Note that '-C <CTEST_BUILD_CONFIGURATION>' is mandatory on windows

#-----------------------------------------------------------------------------
# Dashboard properties
#-----------------------------------------------------------------------------
set(HOSTNAME              "factory-south-ubuntu")
set(MY_QT_VERSION         "4.8.6")
set(CTEST_DASHBOARD_ROOT  "$ENV{HOME}/Dashboards/Package")

set(SVN_BRANCH "trunk") # trunk or branches/Slicer-4.8
set(SVN_REVISION "26489") # Release 4.8.0
set(package_version "480")

# Each dashboard script should specify a unique ID per CTEST_DASHBOARD_ROOT.
# It means the following directories will be created:
#   <CTEST_DASHBOARD_ROOT>/<DIRECTORY_NAME>-<DIRECTORY_IDENTIFIER>        # Source directory
#   <CTEST_DASHBOARD_ROOT>/<DIRECTORY_NAME>-<DIRECTORY_IDENTIFIER>-package  # Build directory
set(DIRECTORY_IDENTIFIER  "${package_version}")

# Open a shell and type in "cmake --help" to obtain the proper spelling of the generator
#set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
#set(MY_BITNESS            "64")

#-----------------------------------------------------------------------------
# Dashboard options
#-----------------------------------------------------------------------------
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(WITH_PACKAGES TRUE)
set(CTEST_BUILD_CONFIGURATION "Release")
#set(CTEST_TEST_TIMEOUT 500)
set(CTEST_BUILD_FLAGS "-j5 -l4") # Use multiple CPU cores to build. For example "-j -l4" on unix
set(CTEST_PARALLEL_LEVEL 8) # Number of tests running in parallel

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
  Slicer_BUILD_CLI:BOOL=ON
  Slicer_USE_PYTHONQT_WITH_OPENSSL:BOOL=ON
  Slicer_USE_VTK_DEBUG_LEAKS:BOOL=OFF
  Slicer_RELEASE_TYPE:STRING=Stable
")

#-----------------------------------------------------------------------------
# List of test that should be explicitly disabled on this machine
#-----------------------------------------------------------------------------
set(TEST_TO_EXCLUDE_REGEX "qMRMLLayoutManagerTest3")

#-----------------------------------------------------------------------------
# Set any extra environment variables here
#-----------------------------------------------------------------------------
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()

#-----------------------------------------------------------------------------
# Required executables
#-----------------------------------------------------------------------------
find_program(CTEST_SVN_COMMAND NAMES svn)
find_program(CTEST_GIT_COMMAND NAMES git)
find_program(CTEST_COVERAGE_COMMAND NAMES gcov)
find_program(CTEST_MEMORYCHECK_COMMAND NAMES valgrind)

#-----------------------------------------------------------------------------
# Factory settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicer_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

#-----------------------------------------------------------------------------
# Build Name
#-----------------------------------------------------------------------------
# Update the following variable to match the chosen build options. This variable is used to
# generate both the build directory and the build name.
# See http://www.cdash.org/CDash/index.php?project=Slicer4 for examples
set(BUILD_OPTIONS_STRING "${MY_BITNESS}bits-QT${MY_QT_VERSION}-NoVTKDebugLeaks")

#-----------------------------------------------------------------------------
# Directory name
#-----------------------------------------------------------------------------
set(DIRECTORY_NAME "Slicer")

#-----------------------------------------------------------------------------
# Build directory
#-----------------------------------------------------------------------------
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DIRECTORY_NAME}-${DIRECTORY_IDENTIFIER}-package")
file(WRITE "${CTEST_DASHBOARD_ROOT}/${DIRECTORY_NAME}-${DIRECTORY_IDENTIFIER}-package - ${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE}.txt" "Generated by ${CTEST_SCRIPT_NAME}")

#-----------------------------------------------------------------------------
# Source directory
#-----------------------------------------------------------------------------
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DIRECTORY_NAME}-${DIRECTORY_IDENTIFIER}")


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
message("CTEST_SITE ................: ${CTEST_SITE}")
message("CTEST_BUILD_NAME ..........: ${CTEST_BUILD_NAME}")
message("SCRIPT_MODE ...............: ${SCRIPT_MODE}")
message("CTEST_BUILD_CONFIGURATION .: ${CTEST_BUILD_CONFIGURATION}")
message("WITH_KWSTYLE ..............: ${WITH_KWSTYLE}")
message("WITH_COVERAGE: ............: ${WITH_COVERAGE}")
message("WITH_MEMCHECK .............: ${WITH_MEMCHECK}")
message("WITH_PACKAGES .............: ${WITH_PACKAGES}")
message("WITH_DOCUMENTATION ........: ${WITH_DOCUMENTATION}")
message("DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY: ${DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY}")

#
# Convenient function allowing to download a file
#
function(download_file url dest)
  file(DOWNLOAD ${url} ${dest} STATUS status)
  list(GET status 0 error_code)
  list(GET status 1 error_msg)
  if(error_code)
    message(FATAL_ERROR "error: Failed to download ${url} - ${error_msg}")
  endif()
endfunction()

#
# Download and include dashboard driver script
#
set(url http://svn.slicer.org/Slicer4/${SVN_BRANCH}/CMake/SlicerDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
include(${dest})
