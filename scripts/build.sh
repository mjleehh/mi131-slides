#!/usr/bin/env bash

projectName=$1

outputDir=output/$projectName
mkdir -p $outputDir

xelatex -output-directory=$outputDir -halt-on-error -interaction=batchmode $projectName/slides.tex
