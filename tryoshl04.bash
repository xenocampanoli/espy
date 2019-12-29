#!/bin/bash

source ./OSHealthLib.bashenv

readonly TD=$HOME/tmp
rm -rf $TD
mkdir -p $TD

for fmt in OneLine Table
do
	for dss in minimum concise detail verbose
	do
		showUptime $fmt $dss >$TD/tryoshl03_${fmt}_${dss}.html
		for color in gainsboro chartreuse hotpink peru green NONE
		do
			showUptime $fmt $dss $color >$TD/tryoshl03_${fmt}_${dss}_${color}.html
			for fs in 7pt 8pt 9pt 10pt 11pt 12pt
			do
				showUptime $fmt $dss $color $fs >$TD/tryoshl03_${fmt}_${dss}_${color}_$fs.html
				#echo "trace $fmt $dss $color $fs"
			done
		done
	done
done
