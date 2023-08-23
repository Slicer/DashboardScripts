#!/usr/bin/env bash

set -eo pipefail

#-------------------------------------------------------------------------------
PROG=$(basename $0)
script_dir=$(cd $(dirname $0) || exit 1; pwd)

app=Slicer
offset=180 # Default to ~6 months
limit=10

#-------------------------------------------------------------------------------
# Convenience functions

err() { echo -e >&2 $@\\n; }
die() { err $@; exit 1; }
disp() { echo -e $@\\n; }
bye() { disp $@; exit 0; }
help() {
    cat >&2 <<ENDHELP
Usage: $PROG [options]

Remove draft ${app} application packages and extensions for revisions older than the Nth most recent ones.

Options:
  -h               this help text
  -n N             allow to specify the number of N newest revisions to keep (default: $offset)
  -l N             allow to limit the number of revision to delete (default: $limit)
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
        -l)
            limit=$2
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
# Sanity checks

# api_key
if [ -z ${GIRDER_API_KEY} ]; then
    die 'error: "GIRDER_API_KEY" env. variable is not set!'
fi

# slicer_package_manager_client
if ! command -v slicer_package_manager_client &> /dev/null; then
    die 'error: "slicer_package_manager_client" not found!'
fi

#-------------------------------------------------------------------------------
# Set variables
server_url=https://slicer-packages.kitware.com
api_url=${server_url}/api/v1

spmc="slicer_package_manager_client --api-url $api_url"

#-------------------------------------------------------------------------------
disp "Removing draft '${app}' extensions for revisions older than the ${offset}th most recent ones and starting with the ${limit}th oldest ones."

cmd="$spmc draft list ${app} --limit 0 --offset ${offset} | tail -n +3 | cut -d' ' -f1 | sort | head -n ${limit}"
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
