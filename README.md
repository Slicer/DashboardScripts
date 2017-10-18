DashboardScripts
================

Collection of dashboard scripts used on `factory` and `factory-south` build machines.

## Rename and update release scripts

Update `FROM_DOT` and `TO_DOT` variables

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
```

## Generate new set of dashboard scripts for a different host

### 1. Install prerequisites
```
pip install docopt==0.6.0
```

### 2. Copy scripts updating the associated hostname
```
./cdashly.py clone "factory-ubuntu" "factory-south-ubuntu" --sitename_suffix="-64bits"
```

### 3. Update common paths

  * First preview the change

```
./cdashly.py replace "factory-south-ubuntu*" "/home/kitware/Dashboards/Support/cmake-2.8.8-Linux-i386" "/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386"
```

  * ... then apply

```
./cdashly.py replace "factory-south-ubuntu*" "/home/kitware/Dashboards/Support/cmake-2.8.8-Linux-i386" "/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386" --apply
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
<HOSTNAME>_(CTKApplauncher, slicer)_common.cmake # Variables MY_QT_VERSION, QT_QMAKE_EXECUTABLE 
```

