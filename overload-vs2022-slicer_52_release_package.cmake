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
dashboard_set(SCRIPT_MODE           "Experimental")   # Experimental, Continuous or Nightly
dashboard_set(Slicer_RELEASE_TYPE   "S")              # (E)xperimental, (P)review or (S)table
dashboard_set(WITH_PACKAGES         TRUE)             # Enable to generate packages
dashboard_set(GIT_TAG               "v5.2.1")         # Specify a tag for Stable release
set(CTEST_UPDATE_VERSION_ONLY 1)
if(APPLE)
  dashboard_set(CMAKE_OSX_DEPLOYMENT_TARGET "10.13")
endif()
dashboard_set(CTEST_CMAKE_GENERATOR "Visual Studio 17 2022")
dashboard_set(CTEST_CMAKE_GENERATOR_PLATFORM "x64")
dashboard_set(CTEST_CMAKE_GENERATOR_TOOLSET "v143")
dashboard_set(COMPILER              "VS2022")         # Used only to set the build name
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

dashboard_set(QT_VERSION          "5.15.2")
dashboard_set(Qt5_DIR             "D:/Support/Qt2/${QT_VERSION}/msvc2019_64/lib/cmake/Qt5")

#   Source directory : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>
#   Build directory  : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>-build
dashboard_set(Slicer_DIRECTORY_BASENAME   "S")
dashboard_set(Slicer_DASHBOARD_SUBDIR     "${Slicer_RELEASE_TYPE}")
# 0: 521
dashboard_set(Slicer_DIRECTORY_IDENTIFIER "0")        # Set to arbitrary integer to distinguish different Experimental/Preview release build
                                                      # Set to Slicer version XYZ for Stable release build

# Build Name: <OPERATING_SYSTEM>-<COMPILER>-<BITNESS>bits-QT<QT_VERSION>[-NoPython][-NoCLI][-NoConsole][-NoVTKDebugLeaks][-<BUILD_NAME_SUFFIX>]-<CTEST_BUILD_CONFIGURATION
set(BUILD_NAME_SUFFIX "")

set(TEST_TO_EXCLUDE_REGEX "")

set(ADDITIONAL_CMAKECACHE_OPTION "
ADDITIONAL_C_FLAGS:STRING=/MP4
ADDITIONAL_CXX_FLAGS:STRING=/MP4
")

# Custom settings
include("${DASHBOARDS_DIR}/Support/Kitware-SlicerPackagesCredential.cmake")
set(ENV{ExternalData_OBJECT_STORES} "${DASHBOARDS_DIR}/.ExternalData")
set(CTEST_SVN_COMMAND "C:/SlikSvn/bin/svn.exe")

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################
if(NOT DEFINED DRIVER_SCRIPT)
  set(url https://raw.githubusercontent.com/Slicer/Slicer/main/CMake/SlicerDashboardDriverScript.cmake)
  set(dest ${DASHBOARDS_DIR}/${EXTENSION_DASHBOARD_SUBDIR}/${CTEST_SCRIPT_NAME}.driver)
  file(DOWNLOAD ${url} ${dest} STATUS status)
  if(NOT status MATCHES "0.*")
    message(FATAL_ERROR "error: Failed to download ${url} - ${status}")
  endif()
  set(DRIVER_SCRIPT ${dest})
endif()
include(${DRIVER_SCRIPT})
