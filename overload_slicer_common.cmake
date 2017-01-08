
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 900) # 15mins

string(TOLOWER "${MY_COMPILER}" _lc_compiler)

if(NOT DEFINED QT_QMAKE_EXECUTABLE)
  set(QT_QMAKE_EXECUTABLE   "D:/Support/qt-${MY_QT_VERSION}-${MY_BITNESS}-${_lc_compiler}-rel/bin/qmake.exe")
endif()

set(MIDAS_PACKAGE_URL http://slicer.kitware.com/midas3)
set(SLICER_PACKAGES_CREDENTIAL_FILE "D:/D/Kitware-SlicerPackagesCredential.cmake")

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

