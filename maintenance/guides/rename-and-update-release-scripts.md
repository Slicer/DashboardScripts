
Rename and update release scripts
=================================

These steps are used when releasing a new version of Slicer.

1. On your workstation, open bash (or Git Bash) terminal and clone the repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

2. Update `FROM_DOT` and `TO_DOT` variables and execute the following statements:

```
FROM_DOT=4.10.2
TO_DOT=5.0.0

FROM_DOT_XY=${FROM_DOT%.*}
TO_DOT_XY=${TO_DOT%.*}

FROM_XYZ=$(echo $FROM_DOT | sed "s/\.//g")
TO_XYZ=$(echo $TO_DOT | sed "s/\.//g")

FROM_XY=$(echo $FROM_DOT_XY | sed "s/\.//g")
TO_XY=$(echo $TO_DOT_XY | sed "s/\.//g")

echo "FROM_DOT [$FROM_DOT] FROM_DOT_XY [$FROM_DOT_XY] FROM_XYZ [$FROM_XYZ] FROM_XY [$FROM_XY]"
echo "  TO_DOT [$TO_DOT]   TO_DOT_XY [$TO_DOT_XY]   TO_XYZ [$TO_XYZ]   TO_XY [$TO_XY]"

# Copy scripts <host>_slicer_<FROM_XYZ>.* to  <host>_slicer_<TO_XYZ>.*
for script in $(find -name "*.*" -not -path ".git" | grep "slicer\_" | grep $FROM_XYZ);  do
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
    $(find -name "*.*" -not -path ".git" | grep $TO_XY) \
    $(find -name "*.*" -not -path ".git" | grep $TO_XYZ) \
  ; do
  echo "Updating $script"
  sed -i -e "s/$FROM_DOT/$TO_DOT/g" $script
  sed -i -e "s/$FROM_DOT_XY/$TO_DOT_XY/g" $script
  sed -i -e "s/$FROM_XYZ/$TO_XYZ/g" $script
  sed -i -e "s/$FROM_XY/$TO_XY/g" $script
done


```

5. On metroplex and if it applies, create a new `slicer-buildenv-*` script corresponding to the [tagged build environment image](https://github.com/Slicer/SlicerBuildEnvironment/blob/master/README.rst#maintainers)

A new script must created for both major and minor Slicer release.
For patch release, if the environment did not change, no new script is needed.

Script are located in `/home/kitware/bin` directory.

Assuming the selected tag is `<name-of-tag>`, the following step will download the
corresponding docker image and generate the script:

```
TAG=<name-of-tag>

IMAGE=qt5-centos7

docker pull slicer/buildenv-${IMAGE}:${TAG}
docker run --rm slicer/buildenv-${IMAGE}:${TAG} > ~/bin/slicer-buildenv-${IMAGE}-${TAG}
chmod u+x ~/bin/slicer-buildenv-${IMAGE}-${TAG}
```

Finally, if it applies, update nightly and release scripts:

```
gedit \
  metroplex.sh \
  metroplex-slicer_${TO_XYZ}_release_package.sh
```


6. Edit and update `GIT_TAG` set in release scripts:

```
gedit \
  factory-south-macos-slicer_${TO_XYZ}_release_package.cmake \
  factory-south-macos-slicerextensions_stable_nightly.cmake \
  metroplex-slicer_${TO_XYZ}_release_package.cmake \
  metroplex-slicerextensions_stable_nightly.cmake \
  overload-vs2015-slicer_${TO_XYZ}_release_package.cmake \
  overload-vs2015-slicerextensions_stable_nightly.cmake
```

* `GIT_TAG` should be set to the tag corresponding to Slicer version <TO_DOT>

7. Review and commit using message like:

```
git add -A
git commit -m "Rename and update Slicer release scripts from $FROM_DOT to $TO_DOT"
```
