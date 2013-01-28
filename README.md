DashboardScripts
================

Collection of dashboard scripts used on `factory` and `factory-south` build machines.


## Generate new set of dashboard scripts for a different host

1. Install prerequisites
```
pip install docopt==0.6.0
```

2. Copy scripts updating the associated hostname
```
./cdashly.py clone "factory-ubuntu" "factory-south-ubuntu" --sitename_suffix="-64bits"
```

3. Update common paths

First preview the change
```
./cdashly.py replace "factory-south-ubuntu*" "/home/kitware/Dashboards/Support/cmake-2.8.8-Linux-i386" "/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386"
```
... then apply
```
./cdashly.py replace "factory-south-ubuntu*" "/home/kitware/Dashboards/Support/cmake-2.8.8-Linux-i386" "/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386" --apply
```

Follow the same approach for:
* /home/kitware/Dashboards/DashboardScripts
* /home/kitware/Dashboards/Logs

4. Manually updates the following files
```
<HOSTNAME>_common.cmake # Variables MY_OPERATING_SYSTEM, MY_COMPILER, CTEST_GIT_COMMAND, CTEST_SVN_COMMAND
<HOSTNAME>_(CTKApplauncher, slicer)_common.cmake # Variables MY_QT_VERSION, QT_QMAKE_EXECUTABLE 
```

