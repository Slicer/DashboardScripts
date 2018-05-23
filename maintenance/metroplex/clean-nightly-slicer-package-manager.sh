#!/bin/sh

echo
echo "### Cleaning the Draft folder"
echo
echo "* offset: $3  (Number of Nightly revision to keep)"
echo
revisionToDelete=$(slicer_package_manager_client --api-url $1 --api-key $2 draft list Slicer --offset $3 | tail -n +3 | cut -d' ' -f1)

echo "List of resource to delete:"
echo

for rev in $revisionToDelete
do
    echo $rev
done

if [[ ! $4 = "-y" ]]
then
  read -p "Do you really want to delete all of these revision? [Yy]" -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
      echo
      echo "CANCELED"
      echo
      [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
  fi
  echo
fi

echo
for rev in $revisionToDelete
do
    slicer_package_manager_client --api-url $1 --api-key $2 draft delete Slicer $rev
done

echo
