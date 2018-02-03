
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 900) # 15mins

set(Slicer_USE_QT5 0)
if(MY_QT_VERSION VERSION_GREATER "5.0.0")
  set(Slicer_USE_QT5 1)
endif()

if(Slicer_USE_QT5)
  set(Qt5_DIR "/Volumes/Dashboards/Support/qt-everywhere-build-${MY_QT_VERSION}/lib/cmake/Qt5")
  if(NOT EXISTS ${Qt5_DIR})
    message(FATAL_ERROR "Qt5_DIR is set to a nonexistent directory [${Qt5_DIR}]")
  endif()
else()
  if(NOT DEFINED QT_QMAKE_EXECUTABLE)
    set(QT_QMAKE_EXECUTABLE   "/Volumes/Dashboards/Support/qt-everywhere-opensource-build-${MY_QT_VERSION}/bin/qmake")
  endif()
endif()

set(MIDAS_PACKAGE_URL http://slicer.kitware.com/midas3)
set(SLICER_PACKAGES_CREDENTIAL_FILE "/Volumes/Dashboards/Support/Kitware-SlicerPackagesCredential.cmake")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_TEST_TIMEOUT MY_QT_VERSION QT_QMAKE_EXECUTABLE Qt5_DIR
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
