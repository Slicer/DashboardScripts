
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 900) # 15mins
set(Qt5_DIR "/Volumes/Dashboards/Support/Qt5.7.1/5.7/clang_64/lib/cmake/Qt5")
set(MIDAS_PACKAGE_URL http://slicer.kitware.com/midas3)
set(SLICER_PACKAGES_CREDENTIAL_FILE "/Volumes/Dashboards/Support/Kitware-SlicerPackagesCredential.cmake")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_TEST_TIMEOUT MY_QT_VERSION Qt5_DIR
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
