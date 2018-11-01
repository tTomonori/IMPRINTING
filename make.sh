#!/bin/sh

set -e
set -x

# Build
xcodebuild $*

# Package
name=`xcodebuild -showBuildSettings | perl -nE 'say $1 if /^ +FULL_PRODUCT_NAME = (.+)$/;'`
pdir="$PWD/Products"
mkdir -p "$pdir"
(cd build/Release; zip -r "$pdir/$name.zip" "$name")
