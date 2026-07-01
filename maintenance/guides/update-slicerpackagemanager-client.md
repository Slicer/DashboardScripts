
Update Slicer Package Manager client
====================================

This guide allows to update the installation of the [slicer-package-manager](http://slicer-package-manager.readthedocs.io)
client allowing to upload Slicer application and extension packages on the server maintained and supported by [Kitware, Inc](https://kitware.com).

## Step 1: Open bash terminal and clone repository

```
cd /tmp
git clone git@github.com:Slicer/DashboardScripts.git
cd DashboardScripts
```

## Step 2: Install new version of the client on each build machine

### macOS and Linux

Since these machines have both SSH installed, the following steps will remotely execute
the install scripts:

1. Open bash terminal and execute the following statements:

```
cd maintenance
make remote-install-slicerpackagemanager-client
```

### Windows

1. Connect to bluestreak using VNC

2. Open a command line terminal

3. Confirm the existing environment is available:

```
C:
dir C:\D\Support\slicer_package_manager-venv\Scripts\pip.exe
```

4. Install one of the following versions.

Latest published release from PyPI:

```
C:
C:\D\Support\slicer_package_manager-venv\Scripts\pip install -U slicer-package-manager-client
```

Latest merged `main` from GitHub:

```
C:
C:\D\Support\slicer_package_manager-venv\Scripts\pip install -U --force-reinstall "git+https://github.com/girder/slicer_package_manager.git@main#subdirectory=python_client"
```

5. Verify the client is available:

```
C:
C:\D\Support\slicer_package_manager-venv\Scripts\slicer_package_manager_client --help
```
