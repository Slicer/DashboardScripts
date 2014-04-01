
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_BUILD_FLAGS "-j2")
set(CTEST_TEST_TIMEOUT 300)

set(MY_QT_VERSION         "4.7.4")
set(QT_QMAKE_EXECUTABLE   "$ENV{HOME}/Dashboards/Support/qt/qt-everywhere-opensource-static-release-${MY_QT_VERSION}/bin/qmake")

set(MIDAS_PACKAGES_CREDENTIAL_FILE "$ENV{HOME}/Dashboards/Support/CTKAppLauncher-MidasPackagesCredential.cmake")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_BUILD_FLAGS CTEST_TEST_TIMEOUT
            MY_QT_VERSION QT_QMAKE_EXECUTABLE
            MIDAS_API_EMAIL MIDAS_API_KEY
            )
  message("-- ${var}: ${${var}}")
endforeach()

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

