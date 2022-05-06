#!/bin/bash

YMD="2022-03-25"
HMS="19:00:00"

NOWTIME=`date +%s`
UNIXTIME=`date +%s --date "$YMD $HMS"`

echo $NOWTIME

echo $UNIXTIME
