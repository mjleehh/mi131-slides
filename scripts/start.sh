#!/usr/bin/env bash

fileName=$1
outFileName=dist/${fileName}.html
createSlidesCommand=./scripts/create-slides.sh
mkdir -p dist

${createSlidesCommand} ${fileName} ${outFileName}
xdg-open ${outFileName}
${createSlidesCommand} ${fileName} ${outFileName} -w
