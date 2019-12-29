#!/bin/bash

source ./StatisticsSupportObject.bashenv

newFO ssof

addNumber ssof 2.25
addNumber ssof 1.35
addNumber ssof .45
addNumber ssof .45
addNumber ssof 1.35
addNumber ssof 2.25

n=$(getN ssof)
echo "trace ssof n:  $n"
sumxs=$(getSumXs ssof)
echo "trace ssof sumxs:  $sumxs"
mu=$(getMu ssof)
echo "trace ssof mu:  $mu"
median=$(getMedian ssof)
echo "trace ssof median:  $median"
sumxxs=$(getSumXXs ssof)
echo "trace ssof sumxxs:  $sumxxs"
v=$(getVariance ssof)
echo "trace ssof v:  $v"
sigma=$(getSigma ssof)
echo "trace ssof sigma:  $sigma"
#getMAD ssof
mad=$(getMAD ssof)
echo "trace ssof mad:  $mad"

deleteFO ssof
