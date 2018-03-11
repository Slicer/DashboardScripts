
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
