
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
./maintenance/factory-south-macos/install-slicerpackagemanager-client.sh
```

### Window

1. Connect to [overload](../overload/REMOTE_IP) using VNC

2. Open a command line terminal

3. Update and execute the following statement:

_TBD_
