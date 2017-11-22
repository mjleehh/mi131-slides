#!/usr/bin/env sh

inFile=$1
shift
outFile=$1
shift

buildCommand=./node_modules/markdown-to-slides/index.js
${buildCommand} --title --level 3 -o ${outFile} $@ ${inFile}
