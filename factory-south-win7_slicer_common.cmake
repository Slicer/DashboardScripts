
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 900) # 15mins

if(NOT DEFINED MY_QT_VERSION)
  set(MY_QT_VERSION "4.8.5")
endif()
if(NOT DEFINED QT_QMAKE_EXECUTABLE)
  set(QT_QMAKE_EXECUTABLE   "C:/D/Support/qt-${MY_QT_VERSION}-${MY_BITNESS}-vs2008-rel/bin/qmake.exe")
endif()

set(MIDAS_PACKAGE_URL http://slicer.kitware.com/midas3)
set(MIDAS_PACKAGE_EMAIL patrick.reynolds@kitware.com)
set(MIDAS_PACKAGE_API_KEY ad4ebd15deb32bf90db6542fff485a26)

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_TEST_TIMEOUT MY_QT_VERSION QT_QMAKE_EXECUTABLE
            MIDAS_PACKAGE_URL MIDAS_PACKAGE_EMAIL MIDAS_PACKAGE_API_KEY
            )
  message("-- ${var}: ${${var}}")
endforeach()

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

