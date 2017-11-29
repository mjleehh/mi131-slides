#!/usr/bin/env sh

inFile=$1
shift
outFile=$1
shift

buildCommand=./node_modules/markdown-to-slides/index.js
${buildCommand} -d -t --level 3 $@ -o ${outFile} ${inFile}
