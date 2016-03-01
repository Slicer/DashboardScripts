
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 900) # 15mins

if(NOT DEFINED MY_QT_VERSION)
  set(MY_QT_VERSION "4.8.5")
endif()
set(QT_QMAKE_EXECUTABLE   "/Users/kitware/Dashboards/Support/qt-everywhere-opensource-build-${MY_QT_VERSION}/bin/qmake")

set(MIDAS_PACKAGE_URL http://slicer.kitware.com/midas3)
set(SLICER_PACKAGES_CREDENTIAL_FILE "/Users/kitware/Dashboards/Support/Kitware-SlicerPackagesCredential.cmake")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_TEST_TIMEOUT MY_QT_VERSION QT_QMAKE_EXECUTABLE
            MIDAS_PACKAGE_URL SLICER_PACKAGES_CREDENTIAL_FILE
            )
  message("-- ${var}: ${${var}}")
endforeach()

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_common.cmake)
include(${SLICER_PACKAGES_CREDENTIAL_FILE})
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})
