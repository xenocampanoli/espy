#!/bin/bash

source ./StatisticsSupportObject.bashenv

seeEspy() {
	declare -r _oName=$1

	n=$(getN $_oName)
	echo "$_oName n:  $n"
	sumxs=$(getSumXs $_oName)
	echo "$_oName sumxs:  $sumxs"
	mu=$(getMu $_oName)
	echo "$_oName mu:  $mu"
	median=$(getMedian $_oName)
	echo "$_oName median:  $median"
	sumxxs=$(getSumXXs $_oName)
	echo "$_oName sumxxs:  $sumxxs"
	v=$(getVariance $_oName)
	echo "$_oName v:  $v"
	sigma=$(getSigma $_oName)
	echo "$_oName sigma:  $sigma"
	mad=$(getMAD $_oName)
	echo "$_oName mad:  $mad"
	mode=$(getFrequencies $_oName mode)
	echo "$_oName mode:  $mode"
	echo "All Frequencies:"
	getFrequencies $_oName alldumped
}
newFO sso2a

addNumber sso2a 3.9
addNumber sso2a 11.2
addNumber sso2a 0.5
addNumber sso2a 4.3
addNumber sso2a 95.0
addNumber sso2a 66.4
addNumber sso2a 0.5

seeEspy sso2a

deleteFO sso2a

echo '..............................'
echo

newFO sso2b
set -o noglob
list=$(ss | awk '{print $5}')
for a in $list
do
	l=${#a}
	addNumber sso2b $l
done
set +o noglob
seeEspy sso2b
deleteFO sso2b
#exit 0
	
newFO sso2c
#set -o noglob
for a in $(ps auxw | awk '{print $11}')
do
	l=${#a}
	addNumber sso2c $l
done
#set +o noglob
seeEspy sso2c
deleteFO sso2c
	
newFO sso2d
#set -o noglob
for a in $(ps auxw | awk '{print $11}')
do
	l=${#a}
	addNumber sso2d $l
done
#set +o noglob
seeEspy sso2d
deleteFO sso2d
	
newFO sso2e
#set -o noglob
for a in $(find /run)
do
	l=${#a}
	addNumber sso2e $l
done
#set +o noglob
seeEspy sso2e
deleteFO sso2e
	
newFO sso2f
#set -o noglob
for a in $(find /etc)
do
	l=${#a}
	addNumber sso2f $l
done
#set +o noglob
seeEspy sso2f
deleteFO sso2f
	
newFO sso2g
#set -o noglob
for a in $(find /dev)
do
	l=${#a}
	addNumber sso2g $l
done
#set +o noglob
seeEspy sso2g
deleteFO sso2g
	
