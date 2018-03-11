
Update CMake version used in nightly builds
===========================================

## Step 1: Open bash terminal and clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

## Step 2: Update the scripts

This step is used to update the version of CMake used in the nightly dashboard scripts.

```
cd maintenance
CMAKE_VERSION=X.Y.Z make nightly-script-cmake-update
```

## Step 3: Install new version of CMake on each build machine

### macOS and Linux

Since these machines have both SSH installed, the following steps will remotely execute
the install scripts:

1. Open bash terminal and execute the following statements:

```
cd maintenance
CMAKE_VERSION=X.Y.Z make remote-install-cmake
```

### Windows

1. Connect to [overload](../overload/REMOTE_IP) using VNC

2. Open a command line terminal as Administrator

3. Update and execute the following statement:

```
@powershell -ExecutionPolicy Unrestricted "$cmakeVersion='3.11.0'; iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/scikit-build/scikit-ci-addons/master/windows/install-cmake.ps1'))"
```

_The one-liner is provided by [scikit-ci-addons](http://scikit-ci-addons.readthedocs.io/en/latest/addons.html#install-cmake-ps1)_
