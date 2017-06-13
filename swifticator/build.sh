#!/bin/bash
swift main.swift
mkdir -p $1.framework
mkdir -p $1.framework/Versions/A/Modules/Sample.swiftmodule
ln -sf A $1.framework/Versions/Current
ln -sf Versions/Current/Modules $1.framework/Modules
ln -sf Versions/Current/Sample $1.framework/Sample
xcrun -sdk macosx swiftc -module-name Sample -emit-library -o $1.framework/Versions/Current/Sample -- code.swift
xcrun -sdk macosx swiftc -module-name Sample -emit-module-path $1.framework/Versions/A/Modules/Sample.swiftmodule/x86_64.swiftmodule -- code.swift
touch $1.framework
