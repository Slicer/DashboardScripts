#!/usr/bin/env bash

set -eo pipefail

#-------------------------------------------------------------------------------
PROG=$(basename $0)
script_dir=$(cd $(dirname $0) || exit 1; pwd)

dashboard_dir=$script_dir

app=Slicer
offset=20

#-------------------------------------------------------------------------------
# Convenience functions

err() { echo -e >&2 $@\\n; }
die() { err $@; exit 1; }
disp() { echo -e $@\\n; }
bye() { disp $@; exit 0; }
help() {
    cat >&2 <<ENDHELP
Usage: $PROG [options]

Remove draft ${app} extensions for revisions older than the Nth most recent ones.

Options:
  -h               this help text
  -n N             allow to specify the number of N newest extension revisions to keep (default: $offset)
  -v               display additional info useful for debugging
  -y               delete revisions without asking for confirmation
ENDHELP
}

#-------------------------------------------------------------------------------
# Parse arguments

confirm=0
verbose=0

while [[ $# != 0 ]]; do
    case $1 in
        -y)
            confirm=1
            shift 1
            ;;
        -v)
            verbose=1
            shift 1
            ;;
        -n)
            offset=$2
            shift 2
            ;;
        -*)
            err 'Unknown option \"$1\"'
            help
            exit 1
            ;;
        *)
            break
            ;;
    esac
done


#-------------------------------------------------------------------------------

server_ip_file=$dashboard_dir/REMOTE_IP
api_key_file=/home/kitware/Dashboards/Slicer/Support/Kitware-SlicerPackagesManager-ApiKey.txt

export PATH=/home/kitware/Support/slicer_extension_package-venv/bin:$PATH

#-------------------------------------------------------------------------------
# Sanity checks

# server_ip
if [ ! -f ${server_ip_file} ]; then
    die 'error: "${server_ip_file}" not found!'
fi

# api_key
if [ ! -f ${api_key_file} ]; then
    die 'error: "${api_key_file}" not found!'
fi

# slicer_package_manager_client
if ! command -v slicer_package_manager_client &> /dev/null; then
    die 'error: "slicer_package_manager_client" not found!'
fi

#-------------------------------------------------------------------------------
# Set variables
server_ip=$(head -n1 ${server_ip_file})
server_port=8080
api_url=http://${server_ip}:${server_port}/api/v1

spmc="slicer_package_manager_client --api-url $api_url --api-key \$(head -n1 ${api_key_file})"

#-------------------------------------------------------------------------------
disp "Removing draft '${app}' extensions for revisions older than the ${offset}th most recent ones."

cmd="$spmc draft list ${app} --offset $offset | tail -n +3 | cut -d' ' -f1"
[[ $verbose == 1 ]] && disp "executing: $cmd"

revisionToDelete=$(eval $cmd)
revisionCount=$(echo $revisionToDelete | wc -w)

disp "Found $revisionCount revisions"
[[ $revisionCount == 0 ]] && bye "bye"

disp "List of $app revisions for which extensions will be removed:\n${revisionToDelete}"

if [[ $confirm == "0" ]]
then
  read -p "Do you really want to delete all extensions associated with these revisions? [Yy]" -n 1 -r
  echo
  [[ ! $REPLY =~ ^[Yy]$ ]] && die "abort"
fi

for rev in $revisionToDelete
do
    cmd="$spmc draft delete ${app} $rev"
    [[ $verbose == 1 ]] && disp "executing: $cmd"
    eval $cmd
    disp
done
