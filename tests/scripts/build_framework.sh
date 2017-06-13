#!/bin/bash
CODE=`mktemp`.swift
swift $3 $CODE $2
mkdir -p $1.framework
mkdir -p $1.framework/Versions/A/Modules/Sample.swiftmodule
ln -sf A $1.framework/Versions/Current
ln -sf Versions/Current/Modules $1.framework/Modules
ln -sf Versions/Current/Sample $1.framework/Sample
xcrun -sdk macosx swiftc -module-name Sample -emit-library -o $1.framework/Versions/Current/Sample -- $CODE
xcrun -sdk macosx swiftc -module-name Sample -emit-module-path $1.framework/Versions/A/Modules/Sample.swiftmodule/x86_64.swiftmodule -- $CODE
touch $1.framework
