
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(ENV{CC} /usr/bin/clang)
set(ENV{CXX} /usr/bin/clang++)

set(MY_OPERATING_SYSTEM   "ElCapitan") # Windows, Linux, Darwin...
set(MY_COMPILER           "clang-800.0.42.1")
set(CTEST_SITE            "${HOSTNAME}-64bits.kitware") # for example: mymachine.kitware, mymachine.bwh.harvard.edu, ...

get_filename_component(CTEST_SCRIPT_NAME_WE ${CTEST_SCRIPT_NAME} NAME_WE)
set(CTEST_LOG_FILE        "/Volumes/Dashboards/Logs/${CTEST_SCRIPT_NAME_WE}.txt")

# Open a shell and type in "cmake --help" to obtain the proper spelling of the generator
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(MY_BITNESS            "64")

#-----------------------------------------------------------------------------
# Required executables
#-----------------------------------------------------------------------------
find_program(CTEST_GIT_COMMAND NAMES git)
find_program(CTEST_SVN_COMMAND NAMES svn)
find_program(CTEST_COVERAGE_COMMAND NAMES gcov)
find_program(CTEST_MEMORYCHECK_COMMAND NAMES valgrind)

#-----------------------------------------------------------------------------
# Cache for External data downloads
#-----------------------------------------------------------------------------
set(ENV{ExternalData_OBJECT_STORES} "/Volumes/Dashboards/.ExternalData")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var MY_OPERATING_SYSTEM MY_COMPILER CTEST_SITE CTEST_LOG_FILE
            CTEST_CMAKE_GENERATOR MY_BITNESS
            CTEST_GIT_COMMAND CTEST_SVN_COMMAND
            CTEST_COVERAGE_COMMAND CTEST_MEMORYCHECK_COMMAND
            )
  message("-- ${var}: ${${var}}")
endforeach()

