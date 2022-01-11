
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

### Window

1. Connect to [overload](../overload/REMOTE_IP) using VNC

2. Open `Git Bash`

3. Execute the following statements:

```
[[ ! -d /d/Support/slicer_package_manager ]] && cd /d/Support && git clone https://github.com/girder/slicer_package_manager
cd /d/Support/slicer_package_manager
git fetch origin
git reset --hard origin/master
```

4. Open a command line terminal

5. If needed, create the environment executing the following statements:

```
D:
C:\Python36-x64\Scripts\virtualenv.exe D:\Support\slicer_package_manager-venv
```

6. Finally, execute the following statements:

```
D:
D:\Support\slicer_package_manager-venv\Scripts\pip install -U girder_client
D:\Support\slicer_package_manager-venv\Scripts\pip install -U D:\Support\slicer_package_manager\python_client
```
