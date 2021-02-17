#!/bin/sh
# borrowed here: http://lpaste.net/94963

# Just quit if amixer isn't installed, you hear when it does not work!
type amixer >/dev/null || exit 1

if [ -z $1 ] ; then
    cmd=status
else
    cmd=$1
fi
if [ -z $2 ] ; then
    amixer_dev="Master"
else
    amixer_dev=$2
fi

case $cmd in
    up)
        amixer_cmd="sset $amixer_dev 1%+"
        ;;
    down)
        amixer_cmd="sset $amixer_dev 1%-"
        ;;
    toggle)
        amixer_cmd="sset $amixer_dev toggle"
        ;;
    *)
        amixer_cmd="sget $amixer_dev"
        ;;
esac

vol=`amixer -D pulse $amixer_cmd | \
    sed -n '/\[[0-9]\{1,3\}\%\].*\[on\]/p' | \
    head -n1`
# if volnoti is installed and the notification daemon for it runs, continue to
# show a notification and otherwise exit with non-zero status.
type volnoti-show >/dev/null && pgrep volnoti >/dev/null || exit 1

if [ -z "$vol" ] ; then
    volnoti-show -m
else
    volnoti-show `echo $vol | sed 's/.*\[\([0-9]\{1,3\}\)\%\].*/\1/'`
fi
