DashboardScripts
================

Collection of dashboard scripts used on `factory` and `factory-south` build machines.


## Generate new set of dashboard scripts for a different host

1. Install prerequisites
```
pip install docopt==0.6.0
```

2. Copy scripts
```
./cdashly.py clone "factory-ubuntu" "factory-south-ubuntu" --sitename_suffix="-64bits"
```

3. Manually updates the following files
```
*.sh
*.bat
*_common.cmake # Variables MY_OPERATING_SYSTEM, MY_COMPILER, CTEST_LOG_FILE, CTEST_GIT_COMMAND, CTEST_SVN_COMMAND
*_slicer_common.cmake # Variables MY_QT_VERSION, QT_QMAKE_EXECUTABLE 
```

