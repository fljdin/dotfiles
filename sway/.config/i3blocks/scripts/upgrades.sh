#!/usr/bin/env bash
# print number of upgradable packages from apt
set -e
source $(dirname $0)/../env

upgradable=$(apt list --upgradable 2>/dev/null | grep -v Listing | wc -l)
test $upgradable -lt 1 && exit 0

echo " $upgradable"
echo $upgradable
echo $PRIMARY_COLOR
exit 0
