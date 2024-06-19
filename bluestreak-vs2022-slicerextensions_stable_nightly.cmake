cmake_minimum_required(VERSION 3.9)
macro(dashboard_set var value)
  if(NOT DEFINED "${var}")
    set(${var} "${value}")
  endif()
endmacro()

dashboard_set(DASHBOARDS_DIR        "C:/D")
dashboard_set(ORGANIZATION          "Kitware")        # One word, no ponctuation
dashboard_set(HOSTNAME              "bluestreak")
dashboard_set(OPERATING_SYSTEM      "Windows10")
dashboard_set(SCRIPT_MODE           "Nightly")        # Experimental, Continuous or Nightly
dashboard_set(Slicer_RELEASE_TYPE   "S")              # (E)xperimental, (P)review or (S)table
dashboard_set(EXTENSIONS_INDEX_BRANCH "5.6")          # "main", X.Y, ...
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
dashboard_set(EXTENSIONS_BUILDSYSTEM_TESTING FALSE)   # If enabled, build <Slicer_SOURCE_DIR>/Extensions/*.s4ext

dashboard_set(QT_VERSION            "5.15.2")         # Used only to set the build name

#   Slicer_SOURCE_DIR: <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>
#   Slicer_DIR       : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>-build
dashboard_set(Slicer_DIRECTORY_BASENAME   "S")
dashboard_set(Slicer_DASHBOARD_SUBDIR     "${Slicer_RELEASE_TYPE}")
# 0: 562
dashboard_set(Slicer_DIRECTORY_IDENTIFIER "0")        # Set to arbitrary integer to distinguish different Experimental/Preview release build
                                                      # Set to Slicer version XYZ for Stable release build
dashboard_set(Slicer_SOURCE_DIR "${DASHBOARDS_DIR}/${Slicer_DASHBOARD_SUBDIR}/${Slicer_DIRECTORY_BASENAME}-${Slicer_DIRECTORY_IDENTIFIER}")
dashboard_set(Slicer_DIR        "${DASHBOARDS_DIR}/${Slicer_DASHBOARD_SUBDIR}/${Slicer_DIRECTORY_BASENAME}-${Slicer_DIRECTORY_IDENTIFIER}-build/Slicer-build")

# CTEST_SOURCE_DIRECTORY: <Slicer_SOURCE_DIR>/Extensions/CMake
# CTEST_BINARY_DIRECTORY: <DASHBOARDS_DIR>/<EXTENSION_DASHBOARD_SUBDIR>/<EXTENSION_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>-E[-T]-b
dashboard_set(EXTENSION_DASHBOARD_SUBDIR   "${Slicer_RELEASE_TYPE}")
dashboard_set(EXTENSION_DIRECTORY_BASENAME "S")

dashboard_set(EXTENSIONS_INDEX_GIT_TAG        "origin/${EXTENSIONS_INDEX_BRANCH}") # origin/main, origin/X.Y, ...
dashboard_set(EXTENSIONS_INDEX_GIT_REPOSITORY "https://github.com/Slicer/ExtensionsIndex.git")

# Build Name: <OPERATING_SYSTEM>-<COMPILER>-<BITNESS>bits-QT<QT_VERSION>[-<BUILD_NAME_SUFFIX>]-<CTEST_BUILD_CONFIGURATION
set(BUILD_NAME_SUFFIX "")

set(ADDITIONAL_CMAKECACHE_OPTION "
")

# Custom settings
include("${DASHBOARDS_DIR}/Support/Kitware-SlicerPackagesCredential.cmake")
set(ENV{ExternalData_OBJECT_STORES} "${DASHBOARDS_DIR}/.ExternalData")
set(ENV{SlicerAutoscoperM_CUDA_PATH} "$ENV{CUDA_PATH_V12_4}")

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################
set(EXTENSIONS_TRACK_QUALIFIER ${EXTENSIONS_INDEX_BRANCH})
if(NOT DEFINED DRIVER_SCRIPT)
  set(url https://raw.githubusercontent.com/Slicer/Slicer/main/Extensions/CMake/SlicerExtensionsDashboardDriverScript.cmake)
  set(dest ${DASHBOARDS_DIR}/${EXTENSION_DASHBOARD_SUBDIR}/${CTEST_SCRIPT_NAME}.driver)
  file(DOWNLOAD ${url} ${dest} STATUS status)
  if(NOT status MATCHES "0.*")
    message(FATAL_ERROR "error: Failed to download ${url} - ${status}")
  endif()
  set(DRIVER_SCRIPT ${dest})
endif()
include(${DRIVER_SCRIPT})
