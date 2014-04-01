cmake_minimum_required(VERSION 2.8)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)
#
# Dashboard properties
#
set(HOSTNAME "district9")
set(MY_COMPILER           "VS2008")
set(CTEST_DASHBOARD_ROOT  "C:/D/N")
set(CTEST_CMAKE_GENERATOR "Visual Studio 9 2008")
set(MY_BITNESS            "32")

#
# Dashboard type
#
set(SCRIPT_MODE "nightly") # "experimental", "continuous", "nightly"

#
# Dashboard options
#
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(WITH_PACKAGES TRUE)
set(CTEST_BUILD_CONFIGURATION "Release")

# Additional CMakeCache options
set(ADDITIONAL_CMAKECACHE_OPTION "
")

# Each dashboard script should specify a unique ID per CTEST_DASHBOARD_ROOT.
# It means the following directories will be created:
#   <CTEST_DASHBOARD_ROOT>/<DIRECTORY_NAME>-<DIRECTORY_IDENTIFIER>        # Source directory
#   <CTEST_DASHBOARD_ROOT>/<DIRECTORY_NAME>-<DIRECTORY_IDENTIFIER>-build  # Build directory
set(DIRECTORY_IDENTIFIER  "0")

# List of test that should be explicitly disabled on this machine
set(TEST_TO_EXCLUDE_REGEX "")

set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_CTKAppLauncher_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################

set(CTEST_NOTES_FILES "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")

#
# Download and include dashboard driver script
#
set(url https://raw.githubusercontent.com/commontk/AppLauncher/master/CMake/ctkAppLauncherDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
include(${dest})
