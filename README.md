DashboardScripts
================

Collection of dashboard scripts used on `factory` and `factory-south` build machines.

Table of Contents:

* [Update CMake version used in nightly builds](#update-cmake-version-used-in-nightly-builds)
   * [Step 1: Update the scripts](#step-1-update-the-scripts)
   * [Step 2: Install new version of CMake on the machine](#step-2-install-new-version-of-cmake-on-the-machine)
      * [factory-south-macos and factory-south-ubuntu](#factory-south-macos-and-factory-south-ubuntu)
      * [overload](#overload)
* [Rename and update release scripts](#rename-and-update-release-scripts)
* [Generate new set of dashboard scripts for a different host](#generate-new-set-of-dashboard-scripts-for-a-different-host)
   * [1. Install prerequisites](#1-install-prerequisites)
   * [2. Copy scripts updating the associated hostname](#2-copy-scripts-updating-the-associated-hostname)
   * [3. Update common paths](#3-update-common-paths)
   * [4. Manually updates the following files](#4-manually-updates-the-following-files)



## Update CMake version used in nightly builds

### Step 1: Update the scripts

These steps are used when updating the version of CMake used in the following night scripts:

```
factory-south-macos.sh
factory-south-ubuntu.sh
overload.bat
```

Steps:

1. Open bash terminal

2. Clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

3. Update `FROM_CMAKE` and `TO_CMAKE` variables and execute the following statements:

```
FROM_CMAKE=3.11.0-rc3
TO_CMAKE=3.11.0

echo "FROM_CMAKE [$FROM_CMAKE]"
echo "  TO_CMAKE [$TO_CMAKE]"

# Update version of CMake used in nightly scripts
for script in overload.bat factory-south-ubuntu.sh factory-south-macos.sh; do
  echo "Updating $script"
  sed -i -e "s/cmake-$FROM_CMAKE/cmake-$TO_CMAKE/g" $script
  sed -i -e "s/CMake-$FROM_CMAKE/CMake-$TO_CMAKE/g" $script
done
```

### Step 2: Install new version of CMake on the machine

These steps are used to update the version of CMake used on the following machine:

```
factory-south-macos
factory-south-ubuntu
overload
```

#### factory-south-macos and factory-south-ubuntu

Since these machines have both SSH installed, the following steps will remotely execute
the update scripts:

1. Open bash terminal and execute the following statements:

```
cd scripts

./factory-south-macos-update-cmake.sh $TO_CMAKE

./factory-south-ubuntu-update-cmake.sh $TO_CMAKE
```

#### overload

1. Connect using VNC

2. Open a command line terminal as Administrator

3. Update and execute the following statement:

```
@powershell -ExecutionPolicy Unrestricted "$cmakeVersion='3.11.0'; iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/scikit-build/scikit-ci-addons/master/windows/install-cmake.ps1'))"
```

_The one-liner is provided by [scikit-ci-addons](http://scikit-ci-addons.readthedocs.io/en/latest/addons.html#install-cmake-ps1)_


## Rename and update release scripts

These steps are used when releasing a new version of Slicer.

1. Open bash terminal

2. Clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

3. Update `FROM_DOT` and `TO_DOT` variables and execute the following statements:

```
FROM_DOT=4.6.2
TO_DOT=4.8.0

FROM_DOT_XY=${FROM_DOT%.*}
TO_DOT_XY=${TO_DOT%.*}

FROM_XYZ=$(echo $FROM_DOT | sed "s/\.//g")
TO_XYZ=$(echo $TO_DOT | sed "s/\.//g")

FROM_XY=$(echo $FROM_DOT_XY | sed "s/\.//g")
TO_XY=$(echo $TO_DOT_XY | sed "s/\.//g")

echo "FROM_DOT [$FROM_DOT] FROM_DOT_XY [$FROM_DOT_XY] FROM_XYZ [$FROM_XYZ] FROM_XY [$FROM_XY]"
echo "  TO_DOT [$TO_DOT]   TO_DOT_XY [$TO_DOT_XY]   TO_XYZ [$TO_XYZ]   TO_XY [$TO_XY]"

# Copy scripts <host>_slicer_<FROM_XYZ>.* to  <host>_slicer_<TO_XYZ>.*
for script in $(find -name "*.*" -not -path ".git" | ack $FROM_XYZ);  do
  new_script=$(echo $script | sed "s/$FROM_XYZ/$TO_XYZ/g");
  echo "Copied $script to  $new_script"
  mv $script $new_script
  sed -i -e "s/$FROM_DOT/$TO_DOT/g" $new_script
  sed -i -e "s/$FROM_DOT_XY/$TO_DOT_XY/g" $new_script
  sed -i -e "s/$FROM_XYZ/$TO_XYZ/g" $new_script
done

# Copy scripts <host>_slicer_<FROM_XY>.* to  <host>_slicer_<TO_XY>.*
for script in $(find -name "*.*" -not -path ".git" | ack $FROM_XY);  do
  new_script=$(echo $script | sed "s/$FROM_XY/$TO_XY/g");
  echo "Copied $script to  $new_script"
  mv $script $new_script
  sed -i -e "s/$FROM_DOT/$TO_DOT/g" $new_script
  sed -i -e "s/$FROM_DOT_XY/$TO_DOT_XY/g" $new_script
  sed -i -e "s/$FROM_XYZ/$TO_XYZ/g" $new_script
done

# Update reference to extension release build in nightly scripts
for script in overload.bat factory-south-ubuntu.sh factory-macos.sh; do
  echo "Updating $script"
  sed -i -e "s/$FROM_DOT/$TO_DOT/g" $script
  sed -i -e "s/$FROM_DOT_XY/$TO_DOT_XY/g" $script
  sed -i -e "s/$FROM_XYZ/$TO_XYZ/g" $script
  sed -i -e "s/$FROM_XY/$TO_XY/g" $script
done
```

5. Edit and update `SVN_BRANCH` and `SVN_REVISION` set in release scripts:

```
gedit \
  overload-vs2013-slicer_${TO_XYZ}_release_package.cmake \
  overload-vs2013-slicerextensions_${TO_XY}_release_nightly.cmake \
  factory-south-ubuntu-slicer_${TO_XYZ}_release_package.cmake \
  factory-south-ubuntu-slicerextensions_${TO_XY}_release_nightly.cmake \
  factory-macos-slicer_${TO_XYZ}_release_package.cmake \
  factory-macos-slicerextensions_${TO_XY}_release_nightly.cmake
```

* If no release branch has been created yet, `SVN_BRANCH` should be set to `trunk`
* `SVN_REVISION` should be set to the revision associated with Slicer version <TO_DOT>

6. Review and commit using message like:

```
git add -A
git commit -m "Rename and update Slicer release scripts from $FROM_DOT to $TO_DOT"
```

## Generate new set of dashboard scripts for a different host

### 1. Install prerequisites
```
pip install docopt==0.6.0
```

### 2. Copy scripts updating the associated hostname
```
./cdashly.py clone "factory-ubuntu" "factory-south-ubuntu"
```

### 3. Update common paths

  * First preview the change

```
./cdashly.py replace "factory-south-ubuntu*" "cmake-3.9.0" "cmake-3.10.0"
```

  * ... then apply

```
./cdashly.py replace "factory-south-ubuntu*" "cmake-3.9.0" "cmake-3.10.0" --apply
```

  * Follow the same approach for:

```
/home/kitware/Dashboards/DashboardScripts
```

```
/home/kitware/Dashboards/Logs
```

### 4. Manually updates the following files

```
<HOSTNAME>_common.cmake # Variables MY_OPERATING_SYSTEM, MY_COMPILER, CTEST_GIT_COMMAND, CTEST_SVN_COMMAND
```

```
<HOSTNAME>_(slicer, slicerextensions)_common.cmake # Variables MY_QT_VERSION, QT_QMAKE_EXECUTABLE
```

