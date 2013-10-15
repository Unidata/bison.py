#!/bin/bash
#set -x

CMD=$1
pwd=`pwd`
DIR=`basename ${pwd}`

# $1=title
function title() {
  echo "${DIR}: $1"
}

FAILED=
SK="-S../../python.skel"

function run() {
case "x${CMD}" in
xclean) clean;;
*) testall
   if test "x$FAILED" = "x" ; then
     echo "*** All Tests Passed"
   else
     echo "*** Failed: ${DIR}"
   fi;;
esac
exit $FAILED
}

