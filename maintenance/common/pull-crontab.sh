#!/usr/bin/env bash

set -ex

script_dir=$(cd $(dirname $0) || exit 1; pwd)

if [[ $# != 1 ]]; then
  echo "Usage: $0 hostname"
  exit 1
fi

dashboard_dir=$script_dir/../$1
source $dashboard_dir/../common/remote_execute.sh

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1 || true

crontab -l

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
(remote_execute /tmp/$script_name) > $dashboard_dir/crontab

echo "Crontab successfully download as $dashboard_dir/crontab"
