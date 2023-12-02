
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
FROM_DOT=5.2.0
TO_DOT=5.2.1

FROM_DOT_XY=${FROM_DOT%.*}
TO_DOT_XY=${TO_DOT%.*}

FROM_XYZ=$(echo $FROM_DOT | sed "s/\.//g")
TO_XYZ=$(echo $TO_DOT | sed "s/\.//g")

FROM_XY=$(echo $FROM_DOT_XY | sed "s/\.//g")
TO_XY=$(echo $TO_DOT_XY | sed "s/\.//g")

echo "FROM_DOT [$FROM_DOT] FROM_DOT_XY [$FROM_DOT_XY] FROM_XYZ [$FROM_XYZ] FROM_XY [$FROM_XY]"
echo "  TO_DOT [$TO_DOT]   TO_DOT_XY [$TO_DOT_XY]   TO_XYZ [$TO_XYZ]   TO_XY [$TO_XY]"

# Update version references in scripts
for script in \
    computron.sh \
    metroplex.sh \
    overload.bat \
    $(find -name "*slicerextensions_stable_nightly.cmake" -not -path "./.git/*" -not -name ".git*") \
    $(find -not -path "./.git/*" -not -name ".git*" | grep $TO_XY) \
    $(find -name "*_stable_package.cmake" -not -path "./.git/*" -not -name ".git*") \
  ; do
  echo "Updating $script"
  sed -i -e "s/$FROM_DOT/$TO_DOT/g" $script
  sed -i -e "s/$FROM_DOT_XY/$TO_DOT_XY/g" $script
  sed -i -e "s/$FROM_XYZ/$TO_XYZ/g" $script
  sed -i -e "s/$FROM_XY/$TO_XY/g" $script
done
```

3. To account for transition from `factory-south-macos` to `computron`:

  * Update `slicerextensions_stable_nightly.cmake` script:

    ```
    mv factory-south-macos-slicerextensions_stable_nightly.cmake computron-slicerextensions_stable_nightly.cmake
    ```

  * Update the script based on the content of `computron-slicerextensions_preview_nightly.cmake`

  * Update `computron.sh` to also include build of `Stable` extensions.

5. On metroplex and if it applies, create a new `slicer-buildenv-*` script corresponding to the [tagged build environment image](https://github.com/Slicer/SlicerBuildEnvironment/blob/main/README.rst#maintainers)

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
  metroplex-slicer_${TO_XY}_release_package.sh
```


6. Edit and update `GIT_TAG` set in release scripts:

```
gedit \
  computron-slicer_${TO_XY}_release_package.cmake \
  computron-slicerextensions_stable_nightly.cmake \
  metroplex-slicer_${TO_XY}_release_package.cmake \
  metroplex-slicerextensions_stable_nightly.cmake \
  overload-vs*-slicer_${TO_XY}_release_package.cmake \
  overload-vs*-slicerextensions_stable_nightly.cmake
```

* `GIT_TAG` should be set to the tag corresponding to Slicer version <TO_DOT>

7. Review and commit using message like:

```
git add -A
if [[ "${TO_XY}" != "${FROM_XY}" ]]; then
  git commit -m "Rename and update Slicer release scripts from $FROM_DOT to $TO_DOT"
else
  git commit -m "slicer $TO_DOT_XY: Update release scripts from $FROM_DOT to $TO_DOT"
fi
```
