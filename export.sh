#!/bin/bash
set -x

if test "x$1" = x ; then
  echo "usage: sh export.sh PROJECTNAME"
  exit 1
fi

# git hub project name
PROJECT="$1"
# name of the inventory file
INVENTORY=Inventory
# name of the export directory
EXPORT=export
DST=$EXPORT/${PROJECT}

FILES=`cat Inventory |tr -d '\r' |tr '\n' '  '`

rm -fr ${EXPORT}
mkdir -p ${DST}

for f in ${FILES} ; do
if test -f $f ; then
  DIR=`dirname $f`
  mkdir -p ${DST}/${DIR}
  cp $f $DST/$f
else
  echo "Missing file: $f" >&2
fi
done

