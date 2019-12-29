#!/bin/bash

source ./StatisticsSupportObject.bashenv

newFO sso1

addNumber sso1 1.9
addNumber sso1 2.8
addNumber sso1 3.7
addNumber sso1 4.6
addNumber sso1 5.5
addNumber sso1 6.4

n=$(getN sso1)
echo "sso1 n:  $n"
sumxs=$(getSumXs sso1)
echo "sso1 sumxs:  $sumxs"
mu=$(getMu sso1)
echo "sso1 mu:  $mu"
median=$(getMedian sso1)
echo "sso1 median:  $median"
sumxxs=$(getSumXXs sso1)
echo "sso1 sumxxs:  $sumxxs"
v=$(getVariance sso1)
echo "sso1 v:  $v"
sigma=$(getSigma sso1)
echo "sso1 sigma:  $sigma"
mad=$(getMAD sso1)
echo "sso1 mad:  $mad"
mode=$(getFrequencies sso1 mode)
echo "sso1 mode:  $mode"

echo "Mode With Score:"
getFrequencies sso1 modewithscore

echo "All Frequencies:"
getFrequencies sso1 alldumped

deleteFO sso1
