
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 20)

set(MY_QT_VERSION "4.7.0")
set(QT_QMAKE_EXECUTABLE "C:/Dashboards/Support/qt-static-release-4.7.0/bin/qmake.exe")

set(MIDAS_PACKAGES_CREDENTIAL_FILE "C:/Dashboards/Support/Kitware-MidasPackagesCredential.cmake")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_TEST_TIMEOUT MY_QT_VERSION QT_QMAKE_EXECUTABLE
            MIDAS_PACKAGES_CREDENTIAL_FILE
            )
  message("-- ${var}: ${${var}}")
endforeach()

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

#-----------------------------------------------------------------------------
# Set any extra environment variables here
#-----------------------------------------------------------------------------
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()

#-----------------------------------------------------------------------------
# Build Name
#-----------------------------------------------------------------------------
# Update the following variable to match the chosen build options. This variable is used to
# generate both the build directory and the build name.
set(BUILD_OPTIONS_STRING "${MY_BITNESS}bits-QT${MY_QT_VERSION}")

#-----------------------------------------------------------------------------
# Directory name
#-----------------------------------------------------------------------------
set(DIRECTORY_NAME "CTKResEdit")

#-----------------------------------------------------------------------------
# Build directory
#-----------------------------------------------------------------------------
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DIRECTORY_NAME}-${DIRECTORY_IDENTIFIER}-build")
file(WRITE "${CTEST_DASHBOARD_ROOT}/${DIRECTORY_NAME}-${DIRECTORY_IDENTIFIER}-build - ${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE}.txt" "Generated by ${CTEST_SCRIPT_NAME}")

#-----------------------------------------------------------------------------
# Source directory
#-----------------------------------------------------------------------------
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/${DIRECTORY_NAME}-${DIRECTORY_IDENTIFIER}")

#
# Project specific properties
#
set(CTEST_PROJECT_NAME "CTKResEdit")
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
