
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

#-----------------------------------------------------------------------------
set(CTEST_BUILD_FLAGS "") # Do not build extension in parallel

#-----------------------------------------------------------------------------
# Git repository
#-----------------------------------------------------------------------------
set(EXTENSIONS_INDEX_GIT_REPOSITORY git://github.com/Slicer/ExtensionsIndex.git)

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var EXTENSIONS_INDEX_GIT_REPOSITORY CTEST_BUILD_FLAGS
            )
  message("-- ${var}: ${${var}}")
endforeach()

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicer_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})
