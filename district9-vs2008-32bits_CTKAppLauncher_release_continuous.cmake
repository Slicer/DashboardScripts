#
# OS: Windows XP x64 SP3
# Hardware: Dual Core i7
# GPU: Nvidia nvs 290
#

# Note: The specific version and processor type of this machine should be reported in the 
# header above. Indeed, this file will be send to the dashboard as a NOTE file. 

cmake_minimum_required(VERSION 2.8)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)

#
# For additional information, see http://www.commontk.org/index.php/CTKAppLauncher:Dashboard_setup
#

#
# Dashboard properties
#
set(MY_OPERATING_SYSTEM "Windows") # Windows, Linux, Darwin... 
set(MY_COMPILER "VS2008")
set(MY_QT_VERSION "4.7")
set(QT_QMAKE_EXECUTABLE "C:/Dashboards/Support/qt-static-release-4.7.0/bin/qmake.exe")
set(CTEST_SITE "district9.kitware") # for example: mymachine.kitware, mymachine.dkfz, ...
set(CTEST_DASHBOARD_ROOT "C:/D/C")
set(CTEST_CMAKE_GENERATOR "Visual Studio 9 2008")

#
# Dashboard options
#
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(CTEST_BUILD_CONFIGURATION "Release")
set(CTEST_TEST_TIMEOUT 20)
set(CTEST_BUILD_FLAGS "") # Use multiple CPU cores to build

# experimental: 
#     - run_ctest() macro will be called *ONE* time
#     - binary directory will *NOT* be cleaned
# continuous: 
#     - run_ctest() macro will be called EVERY 5 minutes ... 
#     - binary directory will *NOT* be cleaned
#     - configure/build will be executed *ONLY* if the repository has been updated
# nightly: 
#     - run_ctest() macro will be called *ONE* time
#     - binary directory *WILL BE* cleaned
set(SCRIPT_MODE "continuous") # "experimental", "continuous", "nightly"

#
# Project specific properties
#
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/CTKAppLauncher")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/CTKAppLauncher-build-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE}")

#
# Additionnal CMakeCache options
#
set(ADDITIONNAL_CMAKECACHE_OPTION "
CMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}
")

# List of test that should be explicitly disabled on this machine
set(TEST_TO_EXCLUDE_REGEX "")

# set any extra environment variables here
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()

find_program(CTEST_COVERAGE_COMMAND NAMES gcov)
find_program(CTEST_MEMORYCHECK_COMMAND NAMES valgrind)
find_program(CTEST_GIT_COMMAND NAMES git PATHS "C:/Program Files (x86)/Git/bin")

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################

set(CTEST_NOTES_FILES "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")

#
# Project specific properties
#
set(CTEST_PROJECT_NAME "CTKAppLauncher")
set(CTEST_BUILD_NAME "${MY_OPERATING_SYSTEM}-${MY_COMPILER}-QT${MY_QT_VERSION}-${CTEST_BUILD_CONFIGURATION}")

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
set(url https://raw.githubusercontent.com/commontk/AppLauncher/master/CMake/ctkAppLauncherDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
include(${dest})
