
Push or pull of crontab settings
================================

These guide details how to manage the crontab settings of dashboard machines.

Two tasks are supported:

* pull: Download and save settings of into `<dashboad_name>/crontab` file.

* push: Install setting found in `<dashboad_name>/crontab` on the remote machine.


## Pulling settings

For a specific dashboard:

```
cd maintenance
make pull-crontab.<dashboard_name>
```

Or all supported dashboards:

```
cd maintenance
make pull-crontab
```

## Pushing settings

For a specific dashboard:

```
cd maintenance
make push-crontab.<dashboard_name>
```

For all supported dashboards:

```
cd maintenance
make push-crontab
```

## recoil (macOS arm64): nightly build scheduled with launchd

On `recoil`, the nightly build (`recoil.sh`) is started by a launchd daemon instead of cron.
Processes started by cron run at a reduced scheduling priority, which on Apple Silicon steers
them to efficiency cores and throttles I/O. This made the nightly build take about 13 hours
instead of about 4 hours.

The crontab of `recoil` is still used to update the dashboard scripts, and the `recoil.sh`
entry in [recoil/crontab](../recoil/crontab) is intentionally commented out.

The launchd daemon is defined in [recoil/org.slicer.dashboard.recoil-nightly.plist](../recoil/org.slicer.dashboard.recoil-nightly.plist).
Installing or updating it requires `sudo`, so it is not managed by the `Makefile` targets.
From a terminal on `recoil` (e.g. using NoMachine or `ssh -t`):

```
# Copy the plist from this repository, e.g. scp maintenance/recoil/org.slicer.dashboard.recoil-nightly.plist svc-dashboard@recoil:T/
plutil -lint ~/T/org.slicer.dashboard.recoil-nightly.plist

# When updating an already installed daemon, unload it first
sudo launchctl bootout system/org.slicer.dashboard.recoil-nightly

sudo install -m 644 -o root -g wheel ~/T/org.slicer.dashboard.recoil-nightly.plist /Library/LaunchDaemons/
sudo launchctl bootstrap system /Library/LaunchDaemons/org.slicer.dashboard.recoil-nightly.plist
```

To check the status of the daemon, including the exit code of the last run:

```
sudo launchctl print system/org.slicer.dashboard.recoil-nightly
```

To start the nightly build immediately instead of waiting for the scheduled time:

```
sudo launchctl kickstart system/org.slicer.dashboard.recoil-nightly
```
