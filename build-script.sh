#!/bin/bash

set -ex

xcodebuild -project "SquarePointOfSaleSDK.xcodeproj" -scheme "SquarePointOfSaleSDK" -sdk iphonesimulator -configuration Debug -PBXBuildsContinueAfterErrors=0 -destination "platform=iOS Simulator,name=iPad Air 2" ACTIVE_ARCH_ONLY=0 build
xcodebuild -workspace "SquarePointOfSaleSDK.xcworkspace" -scheme "SquarePointOfSaleSDKTests" -sdk iphonesimulator -configuration Debug -PBXBuildsContinueAfterErrors=0 -destination "platform=iOS Simulator,name=iPad Air 2" ACTIVE_ARCH_ONLY=0 test
bundle exec pod lib lint --verbose --fail-fast
