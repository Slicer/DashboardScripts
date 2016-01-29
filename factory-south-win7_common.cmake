
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(MY_OPERATING_SYSTEM   "Windows7") # Windows, Linux, Darwin... 
set(CTEST_SITE            "${HOSTNAME}.kitware") # for example: mymachine.kitware, mymachine.bwh.harvard.edu, ...

get_filename_component(CTEST_SCRIPT_NAME_WE ${CTEST_SCRIPT_NAME} NAME_WE)
set(CTEST_LOG_FILE        "C:/D/Logs/${CTEST_SCRIPT_NAME_WE}.txt")

#find_program(CTEST_GIT_COMMAND NAMES git)
set(CTEST_GIT_COMMAND "C:/Program Files (x86)/Git/bin/git.exe")
#find_program(CTEST_SVN_COMMAND NAMES svn)
set(CTEST_SVN_COMMAND "C:/Program Files/SlikSvn/bin/svn.exe")
find_program(CTEST_COVERAGE_COMMAND NAMES gcov)
find_program(CTEST_MEMORYCHECK_COMMAND NAMES valgrind)

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var MY_OPERATING_SYSTEM CTEST_SITE
            CTEST_LOG_FILE CTEST_BUILD_FLAGS
            CTEST_GIT_COMMAND CTEST_SVN_COMMAND
            CTEST_COVERAGE_COMMAND CTEST_MEMORYCHECK_COMMAND
            )
  message("-- ${var}: ${${var}}")
endforeach()

