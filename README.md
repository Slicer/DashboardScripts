DashboardScripts
================

## Overview

This projects is a collection of scripts used to orchestrate the building, testing and packaging of [3D Slicer](https://slicer.org)
and associated extensions on Linux, macOS and Windows dashboard machines.

Ultimately, these scripts and dashboards enable researchers across the world not only to [download](http://download.slicer.org)
both stable and preview releases of 3D Slicer application but also to contribute or install more than hundred extensions.

The overall build infrastructure composed of dashboard machines, CDash server used to collect continuous
integration results, and also server to host and serve application and extension packages is made possible
thanks to the on-going support of [Kitware, Inc](https://kitware.com).

Additionally, this project also provides tooling and instructions to (1) facilitate the maintenance of these script,
(2) update and backup associated _job scheduling configuration_, and (3) update software installed on each dashboards.


## Table of Contents

* [Overview](#overview)
* [Terminology](#terminology)
* [Summary of Scheduled Tasks](#summary-of-scheduled-tasks)
* [Maintenance Guides](#maintenance-guides)
* [Frequently Asked Question](#frequently-asked-question)
   * [Is this infrastructure required to setup my own dashboard ?](#is-this-infrastructure-required-to-setup-my-own-dashboard-)
<!--
Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)
-->

## Terminology

<table>
  <tr>
    <th>Term</th>
    <th>Description</th>
    <th>Synonyms</th>
  </tr>
  <tr>
    <td>dashboard</td>
    <td>Environment  in which Slicer is configured, built, tested and packaged. It corresponds to either a 
physical machine, a virtual machine or a Docker container.
    </td>
    <td>dashboard machine, build machine</td>
  </tr>
  <tr>
</table>

## Summary of Scheduled Tasks

_TBD_

## Maintenance Guides

Software updates:

* [Update CMake version used in nightly builds](maintenance/guides/update-cmake-nightly-build.md)
* [Update Slicer Package Manager client](maintenance/guides/update-slicerpackagemanager-client.md)
* [Update Girder client](maintenance/guides/update-girder-client.md)

Nightly build:

* [Re-trigger nightly build skipping SCM update](maintenance/guides/re-trigger-nightly-build.md)

Release process:

* [Rename and update release scripts](maintenance/guides/rename-and-update-release-scripts.md)

Setting up new dashboards:

* [Push or pull of crontab settings](maintenance/guides/push-pull-crontab-settings.md)
* [Create scripts for a new dashboard](maintenance/guides/create-scripts-for-new-dashboard.md)

## Frequently Asked Question

### Is this infrastructure required to setup my own dashboard ?

No. This project only exists to streamline the maintenance of the build infrastructure provided and supported
by [Kitware, Inc](https://kitware.com).

If you would like to setup nighly build independently, templates used to create each build scripts are
available in the Slicer source repository:

* [SlicerDashboardScript.TEMPLATE.cmake](https://github.com/Slicer/Slicer/blob/master/CMake/SlicerDashboardScript.TEMPLATE.cmake)
* [SlicerExtensionsDashboardScript.TEMPLATE.cmake](https://github.com/Slicer/Slicer/blob/master/Extensions/CMake/SlicerExtensionsDashboardScript.TEMPLATE.cmake)

Reading the [Dashboard Setup tutorial](https://www.slicer.org/wiki/Documentation/Nightly/Developers/Tutorials/DashboardSetup)
and [Developers/FAQ/Dashboard](https://www.slicer.org/wiki/Documentation/Nightly/Developers/FAQ/Dashboard) can be helpful
to address common pitfall.

