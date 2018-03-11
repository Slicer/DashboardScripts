#!/usr/bin/env bash

#
# This script was designed to be sourced.
#
# It expects the following variables to be defined in the caller scope:
#
# * dashboard_dir
#
# It sets the following variables:
#
# * remote_ip
# * remote_username
# * remote_hostname
#
# and defines the following functions:
#
# * remote_execute
#

set -ex

[[ ! -d $dashboard_dir ]] && (echo "dashboard_dir [$dashboard_dir] variable is either not defined or set to a non-existent directory"; exit 1)

remote_ip=$(head -n1 $dashboard_dir/REMOTE_IP)
remote_username=$(head -n1 $dashboard_dir/REMOTE_USERNAME)
remote_hostname=$(head -n1 $dashboard_dir/REMOTE_HOSTNAME)

function remote_execute {
  [[ ! -f $1 ]] && (echo "remote_execute: script [$1] does not exist"; exit 1)
  ssh $remote_username@$remote_ip 'bash -s' < $1
}
