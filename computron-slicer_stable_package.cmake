cmake_minimum_required(VERSION 3.9)
macro(dashboard_set var value)
  if(NOT DEFINED "${var}")
    set(${var} "${value}")
  endif()
endmacro()

dashboard_set(DASHBOARDS_DIR        "/D")
dashboard_set(ORGANIZATION          "Kitware")        # One word, no ponctuation
dashboard_set(HOSTNAME              "computron")
dashboard_set(OPERATING_SYSTEM      "macOS")
dashboard_set(SCRIPT_MODE           "Experimental")   # Experimental, Continuous or Nightly
dashboard_set(Slicer_RELEASE_TYPE   "S")              # (E)xperimental, (P)review or (S)table
dashboard_set(WITH_PACKAGES         TRUE)             # Enable to generate packages
dashboard_set(GIT_TAG               "v5.8.1") # Specify a tag for Stable release
set(CTEST_UPDATE_VERSION_ONLY 1)
if(APPLE)
  dashboard_set(CMAKE_OSX_DEPLOYMENT_TARGET "13.0")
endif()
dashboard_set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
dashboard_set(COMPILER              "clang-14.0.6")    # Used only to set the build name
dashboard_set(CTEST_BUILD_FLAGS     "-j9 -l8")        # Use multiple CPU cores to build. For example "-j -l4" on unix
# By default, CMake auto-discovers the compilers
#dashboard_set(CMAKE_C_COMPILER      "/path/to/c/compiler")
#dashboard_set(CMAKE_CXX_COMPILER    "/path/to/cxx/compiler")
dashboard_set(CTEST_BUILD_CONFIGURATION "Release")
dashboard_set(WITH_MEMCHECK       FALSE)
dashboard_set(WITH_COVERAGE       FALSE)
dashboard_set(WITH_DOCUMENTATION  FALSE)
dashboard_set(Slicer_BUILD_CLI    ON)
dashboard_set(Slicer_USE_PYTHONQT ON)

dashboard_set(QT_VERSION          "5.15.8")
dashboard_set(Qt5_DIR             "${DASHBOARDS_DIR}/Support/qt-everywhere-build-${QT_VERSION}/lib/cmake/Qt5")

#   Source directory : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>
#   Build directory  : <DASHBOARDS_DIR>/<Slicer_DASHBOARD_SUBDIR>/<Slicer_DIRECTORY_BASENAME>-<Slicer_DIRECTORY_IDENTIFIER>-build
dashboard_set(Slicer_DIRECTORY_BASENAME   "S")
dashboard_set(Slicer_DASHBOARD_SUBDIR     "${Slicer_RELEASE_TYPE}")
# 0: 581
dashboard_set(Slicer_DIRECTORY_IDENTIFIER "0")        # Set to arbitrary integer to distinguish different Experimental/Preview release build
                                                      # Set to Slicer version XYZ for Stable release build

# Note: Hyper-short name required on computron (S-0-build -> A)
dashboard_set(CTEST_BINARY_DIRECTORY "${DASHBOARDS_DIR}/${Slicer_DASHBOARD_SUBDIR}/A")
# Build Name: <OPERATING_SYSTEM>-<COMPILER>-<BITNESS>bits-QT<QT_VERSION>[-NoPython][-NoCLI][-NoVTKDebugLeaks][-<BUILD_NAME_SUFFIX>]-<CTEST_BUILD_CONFIGURATION
set(BUILD_NAME_SUFFIX "")

# Line 194 qSlicerSequencesModule widget has a minimum size hint width of 726px.
# It is wider than the maximum allowed width of 500px. (maximum allowed width computed as: 500px or 30% of screen width of 1280px)
set(TEST_TO_EXCLUDE_REGEX "qSlicerSequencesModuleWidgetGenericTest")

# Line 194 qSlicerReformatModule widget has a minimum size hint width of 550px.
# It is wider than the maximum allowed width of 500px. (maximum allowed width computed as: 500px or 30% of screen width of 1280px)
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|qSlicerReformatModuleWidgetGenericTest")

# Test fails with "Couldn't mmap icu data file", the error is specific to the build tree.
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|py_WebEngine")

# FPE Exception occuring with this module for few years. See https://www.slicer.org/wiki/Developer_Meetings/20140826
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|N4ITKBiasFieldCorrectionTest")

# PE Signal Caught / signal:  SIGFPE with code FPE_FLTOVF
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|ModelMakerGenerateAllOneLabelTest")

# Disable tests known to fail
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|CastScalarVolumeTest_UnsignedChar")
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|CastScalarVolumeTest_UnsignedShort")
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|qMRMLUtf8Test1_cube-utf8.mrml")
set(TEST_TO_EXCLUDE_REGEX "${TEST_TO_EXCLUDE_REGEX}|py_nomainwindow_SegmentationsModuleTest2")

set(ADDITIONAL_CMAKECACHE_OPTION "
CMAKE_C_COMPILER:FILEPATH=/D/Support/clang+llvm-14.0.6-x86_64-apple-darwin/bin/clang
CMAKE_CXX_COMPILER:FILEPATH=/D/Support/clang+llvm-14.0.6-x86_64-apple-darwin/bin/clang++
")

# Custom settings
include("${DASHBOARDS_DIR}/Support/Kitware-SlicerPackagesCredential.cmake")
set(ENV{ExternalData_OBJECT_STORES} "${DASHBOARDS_DIR}/.ExternalData")

# This will ensure compiler paths specified using the cache variable are used
# consistently.
set(ENV{CC} "/dev/null")
set(ENV{CXX} "/dev/null")

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

