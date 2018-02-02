
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 900) # 15mins

string(TOLOWER "${MY_COMPILER}" _lc_compiler)

set(Slicer_USE_QT5 0)
if(MY_QT_VERSION VERSION_GREATER "5.0.0")
  set(Slicer_USE_QT5 1)
endif()

if(Slicer_USE_QT5)
  set(qt_compiler_name_VS2015 "msvc2015")
  set(qt_compiler_name_VS2017 "msvc2017")
  if(NOT DEFINED qt_compiler_name_${MY_COMPILER})
    message(FATAL_ERROR "Variable 'qt_compiler_name_${MY_COMPILER}' is not defined: Unknown value for MY_COMPILER variable [${MY_COMPILER}]")
  endif()
  set(Qt5_DIR "D:/Support/Qt/${MY_QT_VERSION}/${qt_compiler_name_${MY_COMPILER}}_${MY_BITNESS}/lib/cmake/Qt5")
  if(NOT EXISTS ${Qt5_DIR})
    message(FATAL_ERROR "Qt5_DIR is set to a nonexistent directory [${Qt5_DIR}]")
  endif()
else()
  if(NOT DEFINED QT_QMAKE_EXECUTABLE)
    set(QT_QMAKE_EXECUTABLE   "D:/Support/qt-${MY_QT_VERSION}-${MY_BITNESS}-${_lc_compiler}-rel/bin/qmake.exe")
  endif()
endif()

set(MIDAS_PACKAGE_URL http://slicer.kitware.com/midas3)
set(SLICER_PACKAGES_CREDENTIAL_FILE "D:/D/Kitware-SlicerPackagesCredential.cmake")

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

