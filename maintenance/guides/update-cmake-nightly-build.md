
Update CMake version used in nightly builds
===========================================

## Step 1: Open bash terminal and clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

## Step 2: Update the scripts

These steps are used to update the version of CMake used in the dashboard scripts.

2. Update `FROM_CMAKE` and `TO_CMAKE` variables and execute the following statements:

```
FROM_CMAKE=3.11.0-rc3
TO_CMAKE=3.11.0

echo "FROM_CMAKE [$FROM_CMAKE]"
echo "  TO_CMAKE [$TO_CMAKE]"

DASHBOARDS="
factory-south-macos.sh
factory-south-ubuntu.sh
overload.bat
"

for script in $DASHBOARDS; do
  echo "Updating $script"
  sed -i -e "s/cmake-$FROM_CMAKE/cmake-$TO_CMAKE/g" $script
  sed -i -e "s/CMake-$FROM_CMAKE/CMake-$TO_CMAKE/g" $script
done
```

## Step 3: Install new version of CMake on each build machine

### macOS and Linux

Since these machines have both SSH installed, the following steps will remotely execute
the install scripts:

1. Open bash terminal and execute the following statements:

```
./maintenance/factory-south-macos/install-cmake.sh $TO_CMAKE

./maintenance/factory-south-ubuntu/install-cmake.sh $TO_CMAKE
```

### Windows

1. Connect to [overload](../overload/IP) using VNC

2. Open a command line terminal as Administrator

3. Update and execute the following statement:

```
@powershell -ExecutionPolicy Unrestricted "$cmakeVersion='3.11.0'; iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/scikit-build/scikit-ci-addons/master/windows/install-cmake.ps1'))"
```

_The one-liner is provided by [scikit-ci-addons](http://scikit-ci-addons.readthedocs.io/en/latest/addons.html#install-cmake-ps1)_
