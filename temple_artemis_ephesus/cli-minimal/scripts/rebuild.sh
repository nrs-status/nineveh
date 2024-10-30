#!/bin/sh

DATE=$(date "+%Y-%m-%d_%H-%M-%S")

if [ "$#" -eq 0 ]; then
	COMMIT_MSG="autocommit $DATE"
else
	COMMIT_MSG=$1
fi

LOC=$PWD
cd /etc/nixos
git add -A
nixos-rebuild switch --flake github:nrs-status/nineveh/new |& tee /var/log/nixos-rebuild/"$DATE"
cd "$LOC"
