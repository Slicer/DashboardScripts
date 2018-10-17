
Rename and update release scripts
=================================

These steps are used when releasing a new version of Slicer.

1. Open bash terminal and clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

2. Update `FROM_DOT` and `TO_DOT` variables and execute the following statements:

```
FROM_DOT=4.8.1
TO_DOT=4.10.0

FROM_DOT_XY=${FROM_DOT%.*}
TO_DOT_XY=${TO_DOT%.*}

FROM_XYZ=$(echo $FROM_DOT | sed "s/\.//g")
TO_XYZ=$(echo $TO_DOT | sed "s/\.//g")

FROM_XY=$(echo $FROM_DOT_XY | sed "s/\.//g")
TO_XY=$(echo $TO_DOT_XY | sed "s/\.//g")

echo "FROM_DOT [$FROM_DOT] FROM_DOT_XY [$FROM_DOT_XY] FROM_XYZ [$FROM_XYZ] FROM_XY [$FROM_XY]"
echo "  TO_DOT [$TO_DOT]   TO_DOT_XY [$TO_DOT_XY]   TO_XYZ [$TO_XYZ]   TO_XY [$TO_XY]"

# Copy scripts <host>_slicer_<FROM_XYZ>.* to  <host>_slicer_<TO_XYZ>.*
for script in $(find -name "*.*" -not -path ".git" | ack "slicer\_" | ack $FROM_XYZ);  do
  new_script=$(echo $script | sed "s/$FROM_XYZ/$TO_XYZ/g");
  echo "Renamed $script to  $new_script"
  mv $script $new_script
done

# Update version references in scripts
for script in \
    factory-south-macos.sh \
    metroplex.sh \
    overload.bat \
    $(find -name "*slicerextensions_stable_nightly.cmake" -not -path ".git") \
    $(find -name "*.*" -not -path ".git" | ack $TO_XY) \
    $(find -name "*.*" -not -path ".git" | ack $TO_XYZ) \
  ; do
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
  factory-south-macos-slicer_${TO_XYZ}_release_package.cmake \
  factory-south-macos-slicerextensions_stable_nightly.cmake \
  metroplex-slicer_${TO_XYZ}_release_package.cmake \
  metroplex-slicerextensions_stable_nightly.cmake \
  overload-vs2015-slicer_${TO_XYZ}_release_package.cmake \
  overload-vs2015-slicerextensions_stable_nightly.cmake
```

* If no release branch has been created yet, `SVN_BRANCH` should be set to `trunk`
* `SVN_REVISION` should be set to the revision associated with Slicer version <TO_DOT>

6. Review and commit using message like:

```
git add -A
git commit -m "Rename and update Slicer release scripts from $FROM_DOT to $TO_DOT"
```
