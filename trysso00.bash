#!/bin/bash

source ./StatisticsSupportObject.bashenv

newFO sso0

addNumber sso0 1

n=$(getN sso0)
echo "sso0 n:  $n"

deleteFO sso0
