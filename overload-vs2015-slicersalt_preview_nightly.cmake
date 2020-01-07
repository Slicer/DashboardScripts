cmake_minimum_required(VERSION 3.9)
macro(dashboard_set var value)
  if(NOT DEFINED "${var}")
    set(${var} "${value}")
  endif()
endmacro()

dashboard_set(DASHBOARDS_DIR        "D:/D/")
dashboard_set(ORGANIZATION          "Kitware")        # One word, no ponctuation
dashboard_set(HOSTNAME              "overload")
dashboard_set(OPERATING_SYSTEM      "Windows10")
dashboard_set(SCRIPT_MODE           "Nightly")        # Experimental, Continuous or Nightly
dashboard_set(Slicer_RELEASE_TYPE   "P")              # (E)xperimental, (P)review or (S)table
# TODO: Re-enable packaging when automatic upload to Girder will be implemented
dashboard_set(WITH_PACKAGES         FALSE)             # Enable to generate packages
if(APPLE)
  dashboard_set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9")
endif()
dashboard_set(CTEST_CMAKE_GENERATOR "Visual Studio 14 2015 Win64")
dashboard_set(COMPILER              "VS2015")         # Used only to set the build name
dashboard_set(CTEST_BUILD_FLAGS     "/maxcpucount:4") # Use multiple CPU cores to build. For example "-j -l4" on unix
# By default, CMake auto-discovers the compilers
#dashboard_set(CMAKE_C_COMPILER      "/path/to/c/compiler")
#dashboard_set(CMAKE_CXX_COMPILER    "/path/to/cxx/compiler")
dashboard_set(CTEST_BUILD_CONFIGURATION "Release")
dashboard_set(WITH_MEMCHECK       FALSE)
dashboard_set(WITH_COVERAGE       FALSE)
dashboard_set(WITH_DOCUMENTATION  FALSE)
dashboard_set(Slicer_BUILD_CLI    ON)
dashboard_set(Slicer_USE_PYTHONQT ON)

dashboard_set(QT_VERSION          "5.10.1")
dashboard_set(Qt5_DIR             "D:/Support/Qt/${QT_VERSION}/msvc2015_64/lib/cmake/Qt5")

#   Source directory : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>
#   Build directory  : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>-build
dashboard_set(Slicer_DIRECTORY_BASENAME   "SSALT")
dashboard_set(Slicer_DASHBOARD_SUBDIR     "${Slicer_RELEASE_TYPE}")
dashboard_set(Slicer_DIRECTORY_IDENTIFIER "0")        # Set to arbitrary integer to distinguish different Experimental/Preview release build
                                                      # Set to Slicer version XYZ for Stable release build

# Set GIT_REPOSITORY and GIT_TAG for the project
dashboard_set(GIT_REPOSITORY "https://github.com/Kitware/SlicerSALT")
dashboard_set(GIT_TAG        "master")

# Build Name: <OPERATING_SYSTEM>-<COMPILER>-<BITNESS>bits-QT<QT_VERSION>[-NoPython][-NoCLI][-NoConsole][-NoVTKDebugLeaks][-<BUILD_NAME_SUFFIX>]-<CTEST_BUILD_CONFIGURATION
set(BUILD_NAME_SUFFIX "")

set(TEST_TO_EXCLUDE_REGEX "")

set(ADDITIONAL_CMAKECACHE_OPTION "
ADDITIONAL_C_FLAGS:STRING=/MP4
ADDITIONAL_CXX_FLAGS:STRING=/MP4
")

# Custom settings
include("${DASHBOARDS_DIR}/Support/Kitware-SlicerSALTPackagesCredential.cmake")
set(ENV{ExternalData_OBJECT_STORES} "${DASHBOARDS_DIR}/.ExternalData")
set(CTEST_SVN_COMMAND "C:/SlikSvn/bin/svn.exe")
set(ENV{FC} "C:\\Miniconda3\\envs\\flang-env\\Library\\bin\\flang.exe") # For LAPACKE

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
