#!/bin/bash
mkdir -p $2.framework
mkdir -p $2.framework/Versions/A/Modules/Sample.swiftmodule
ln -sf A $2.framework/Versions/Current
ln -sf Versions/Current/Modules $2.framework/Modules
ln -sf Versions/Current/Sample $2.framework/Sample
xcrun -sdk macosx swiftc -module-name Sample -emit-library -o $2.framework/Versions/Current/Sample -- $1
xcrun -sdk macosx swiftc -module-name Sample -emit-module-path $2.framework/Versions/A/Modules/Sample.swiftmodule/x86_64.swiftmodule -- $1
touch $2.framework
