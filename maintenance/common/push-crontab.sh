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
# Set script properties
#

crontab_content=$(cat $dashboard_dir/crontab)

#------------------------------------------------------------------------------
# Generate script
#
script_name=$(basename $0)
cat << REMOTE_SCRIPT_EOF > /tmp/$script_name

set -ex

[[ \$(hostname) != "${remote_hostname}" ]] && exit 1

cat << REMOTE_CRONTAB_EOF > /tmp/crontab
${crontab_content}
REMOTE_CRONTAB_EOF

crontab /tmp/crontab

REMOTE_SCRIPT_EOF

#------------------------------------------------------------------------------
# Execute script on remote
#
remote_execute /tmp/$script_name

echo "Crontab successfully installed"
