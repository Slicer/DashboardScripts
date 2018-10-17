Re-trigger nightly build skipping SCM update
============================================

This guide explains how to restart the nighty build after they were automatically
started by the task scheduler.

Why? When a fix is integrated after the start time, manually killing the build jobs and restarting
them will give an other chance for the build script to complete and upload packages.

## Step 1: Kill the current build job

On windows, start _Process Explorer from SysInternals_ and kill the process build tree
associated with `ctest`.

On unix, identify the process id associated with the build job, and run `kill -s SGKILL <PID>`

## Step 2: Update the local source checkout

### windows

```
D:
cd D:\D\P\Slicer-0
svn up
```

### unix

On macOS:

```
cd /Volumes/Dashboards/Preview/Slicer-0
svn up
```

On Linux:

```
cd ~/Dashboards/Slicer/Preview/Slicer-0
svn up
```

## Step 3: Re-trigger the build script

### windows

```
set run_ctest_with_disable_clean=TRUE
set run_ctest_with_update=FALSE

echo %run_ctest_with_disable_clean%
echo %run_ctest_with_update%

D:\D\DashboardScripts\overload.bat
```

### unix

First, start the terminal multiplexer_

```
screen
```

Then, disable clean-up of exising build directory as well as source checkout update:

```
export run_ctest_with_disable_clean=TRUE
export run_ctest_with_update=FALSE
```

Finally, on macOS

```
/Volumes/Dashboards/DashboardScripts/factory-south-macos.sh > /Volumes/Dashboards/Logs/factory-south-macos.log 2>&1
```

and on Linux:

```
/home/kitware/Dashboards/Slicer/DashboardScripts/metroplex.sh --with-itk-dashboard > /home/kitware/Dashboards/Slicer/Logs/metroplex.log 2>&1
```
