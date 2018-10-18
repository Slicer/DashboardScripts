cmake_minimum_required(VERSION 3.9)
macro(dashboard_set var value)
  if(NOT DEFINED "${var}")
    set(${var} "${value}")
  endif()
endmacro()

dashboard_set(DASHBOARDS_DIR        "/work")
dashboard_set(ORGANIZATION          "Kitware")        # One word, no ponctuation
dashboard_set(HOSTNAME              "metroplex")
dashboard_set(OPERATING_SYSTEM      "Linux")
dashboard_set(SCRIPT_MODE           "Nightly")        # Experimental, Continuous or Nightly
dashboard_set(Slicer_RELEASE_TYPE   "Preview")        # (E)xperimental, (P)review or (S)table
# TODO: Re-enable packaging when automatic upload to Girder will be implemented
dashboard_set(WITH_PACKAGES         FALSE)             # Enable to generate packages
if(APPLE)
  dashboard_set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9")
endif()
dashboard_set(CTEST_CMAKE_GENERATOR "Ninja")
dashboard_set(COMPILER              "g++-5.3.1")      # Used only to set the build name
dashboard_set(CTEST_BUILD_FLAGS     "")               # Use multiple CPU cores to build. For example "-j -l4" on unix
# By default, CMake auto-discovers the compilers
#dashboard_set(CMAKE_C_COMPILER      "/path/to/c/compiler")
#dashboard_set(CMAKE_CXX_COMPILER    "/path/to/cxx/compiler")
dashboard_set(CTEST_BUILD_CONFIGURATION "Release")
dashboard_set(WITH_MEMCHECK       FALSE)
dashboard_set(WITH_COVERAGE       FALSE)
dashboard_set(WITH_DOCUMENTATION  FALSE)
dashboard_set(Slicer_BUILD_CLI    ON)
dashboard_set(Slicer_USE_PYTHONQT ON)

dashboard_set(QT_VERSION          "5.11.2")
dashboard_set(Qt5_DIR             "$ENV{Qt5_DIR}")

#   Source directory : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>
#   Build directory  : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>-build
dashboard_set(Slicer_DIRECTORY_BASENAME   "SSALT")
dashboard_set(Slicer_DASHBOARD_SUBDIR     "${Slicer_RELEASE_TYPE}")
dashboard_set(Slicer_DIRECTORY_IDENTIFIER "0")        # Set to arbitrary integer to distinguish different Experimental/Preview release build
                                                      # Set to Slicer version XYZ for Stable release build

# Set GIT_REPOSITORY and GIT_TAG for the project
dashboard_set(GIT_REPOSITORY "https://github.com/Kitware/SlicerSALT")
dashboard_set(GIT_TAG        "master")

# Build Name: <OPERATING_SYSTEM>-<COMPILER>-<BITNESS>bits-QT<QT_VERSION>[-NoPython][-NoCLI][-NoVTKDebugLeaks][-<BUILD_NAME_SUFFIX>]-<CTEST_BUILD_CONFIGURATION
set(BUILD_NAME_SUFFIX "")

set(TEST_TO_EXCLUDE_REGEX "")

set(ADDITIONAL_CMAKECACHE_OPTION "
CMAKE_JOB_POOLS:STRING=compile=16;link=8
CMAKE_JOB_POOL_COMPILE:STRING=compile
CMAKE_JOB_POOL_LINK:STRING=link
")

# Custom settings
include("${DASHBOARDS_DIR}/Support/Kitware-SlicerSALTPackagesCredential.cmake")

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################
if(NOT DEFINED DRIVER_SCRIPT)
  set(url http://svn.slicer.org/Slicer4/trunk/CMake/SlicerDashboardDriverScript.cmake)
  set(dest ${DASHBOARDS_DIR}/${EXTENSION_DASHBOARD_SUBDIR}/${CTEST_SCRIPT_NAME}.driver)
  file(DOWNLOAD ${url} ${dest} STATUS status)
  if(NOT status MATCHES "0.*")
    message(FATAL_ERROR "error: Failed to download ${url} - ${status}")
  endif()
  set(DRIVER_SCRIPT ${dest})
endif()
include(${DRIVER_SCRIPT})
