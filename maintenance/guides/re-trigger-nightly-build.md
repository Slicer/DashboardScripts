Re-trigger nightly build skipping SCM update
============================================

This guide explains how to restart the nighty build after they were automatically
started by the task scheduler.

Why? When a fix is integrated after the start time, manually killing the build jobs and restarting
them will give an other chance for the build script to complete and upload packages.

## Step 1: Kill the current build job

On windows, start _Process Explorer from SysInternals_ and kill the process build tree
associated with `ctest`.

On unix, identify the process id associated with the build job, and run `kill -s SIGKILL <PID>`

## Step 2: Update the local source checkout

### windows

1. Open `Git Bash`

2. Execute the following statements:

```
cd /d/D/P/S-0
git fetch origin
git reset --hard origin/main
```

### unix

On macOS:

```
cd /D/P/S-0

git fetch origin
git reset --hard origin/main
```

On Linux:

```
cd /home/kitware/Dashboards/Slicer/Preview/Slicer-0
git fetch origin
git reset --hard origin/main
```

## Step 3: Remove CDash entries

1. Login to https://slicer.cdash.org/index.php?project=SlicerPreview

2. Remove the relevant builds

## Step 4: Re-trigger the build script

### windows

1. Open `Git Bash` and execute the following statements:

```
# Explicitly remove previous extensions build directory
rm -rf /d/D/P/S-0-E-b
```

2. Open `Command Prompt` and execute the following statements:

```
set run_ctest_with_disable_clean=TRUE
set run_ctest_with_update=FALSE

echo %run_ctest_with_disable_clean%
echo %run_ctest_with_update%

D:\D\DashboardScripts\overload.bat
```

### unix

First, start the terminal multiplexer:

```
screen
```

Then, execute the following statements:

```
export run_ctest_with_disable_clean=TRUE
export run_ctest_with_update=FALSE
```

Finally, on macOS

```
# Explicitly remove previous extensions build directory
rm -rf /D/P/S-0-E-b

# Start build
/D/DashboardScripts/computron.sh > /D/Logs/computron.log 2>&1
```

and on Linux:

```
# Explicitly remove previous extensions build directory
rm -rf /home/kitware/Dashboards/Slicer/Preview/S-0-E-b

/home/kitware/Dashboards/Slicer/DashboardScripts/metroplex.sh > /home/kitware/Dashboards/Slicer/Logs/metroplex.log 2>&1
```
