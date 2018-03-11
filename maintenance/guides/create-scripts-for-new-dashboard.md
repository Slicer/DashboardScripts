
Create scripts for a new dashboard
==================================

## Step 1: Open bash terminal and clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

## Step 2: Install helper tool

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
pip install DashboardScripts/scripts/cdashly
```

## Step 3: Copy scripts updating the associated hostname

```
cdashly clone "factory-ubuntu" "factory-south-ubuntu"
```

## Step 4: Update common paths

  * First preview the change

```
cdashly replace "factory-south-ubuntu*" "cmake-3.9.0" "cmake-3.10.0"
```

  * ... then apply

```
cdashly replace "factory-south-ubuntu*" "cmake-3.9.0" "cmake-3.10.0" --apply
```

  * Follow the same approach for:

```
/home/kitware/Dashboards/DashboardScripts
```

```
/home/kitware/Dashboards/Logs
```

## Step 5: Manually updates the following files

```
<HOSTNAME>_common.cmake # Variables MY_OPERATING_SYSTEM, MY_COMPILER, CTEST_GIT_COMMAND, CTEST_SVN_COMMAND
```

```
<HOSTNAME>_(slicer, slicerextensions)_common.cmake # Variables MY_QT_VERSION, QT_QMAKE_EXECUTABLE
```
