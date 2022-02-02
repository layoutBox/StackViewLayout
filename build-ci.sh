DERIVED_DATA=${1:-/tmp/StackViewLayout}

set -e 
set -o pipefail 
rm -rf $DERIVED_DATA

echo "===============================" 
echo "iOS build & unit test"           
echo "===============================" 
time xcodebuild clean build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -sdk iphonesimulator15.2 -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   -configuration "Release" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty 
    
time xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -sdk iphonesimulator15.2 -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   -configuration "Debug" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty 
    
time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -sdk iphonesimulator15.2 -destination 'platform=iOS Simulator,name=iPhone 8,OS=12.2' \
   -configuration "Release" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty 

time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -sdk iphonesimulator15.2 -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
   -configuration "Release" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty 

echo "===============================" 
echo "StackViewLayoutExample"          
echo "===============================" 
time xcodebuild build -workspace StackViewLayout.xcworkspace -scheme StackViewLayoutExample \
   -sdk iphonesimulator15.2 -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2'  \
   -configuration "Release" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty 

time xcodebuild build -workspace StackViewLayout.xcworkspace -scheme StackViewLayoutExample \
   -sdk iphonesimulator15.2 \
   -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   -configuration "Release" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty 

echo "==============================="
echo "tvOS build "                     
echo "==============================="
time  xcodebuild -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-tvOS \
   -sdk appletvsimulator13.2 -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=15.2' \
   -configuration "Release" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty

time  xcodebuild -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-tvOS \
   -sdk appletvsimulator13.2 -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=15.2' \
   -configuration "Debug" \
   -derivedDataPath $DERIVED_DATA \
   | xcpretty

# echo "===============================" 
# echo "macOS unit test"                 
# echo "==============================="  
# time  xcodebuild clean test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-macOS -sdk macosx10.15 \
#    | xcpretty 

# echo "===============================" 
# echo " Cocoapods: iOS Empty project"   
# echo "===============================" 
# cd TestProjects/cocoapods/ios 
# rm -rf $DERIVED_DATA 
# pod install 
# time xcodebuild clean build -workspace StackViewLayout-iOS.xcworkspace -scheme StackViewLayout-iOS \
#     -sdk iphonesimulator15.2 -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
#     | xcpretty 
# cd ../../.. 

# echo "===============================" 
# echo " Cocoapods: tvOS Empty project"  
# echo "===============================" 
# cd TestProjects/cocoapods/tvos 
# rm -rf $DERIVED_DATA 
# pod install 
# time xcodebuild clean build -workspace StackViewLayout-tvOS.xcworkspace -scheme StackViewLayout-tvOS \
#     -sdk appletvsimulator13.2 -destination 'platform=tvOS Simulator,name=Apple TV,OS=15.2' \
#     | xcpretty 
# cd ../../.. 


# echo "===============================" 
# echo " Carthage: iOS Empty project"    
# echo "===============================" 
# cd TestProjects/carthage/ios 
# rm -rf $DERIVED_DATA 
# rm Cartfile 
# echo "git \"$TRAVIS_BUILD_DIR\" \"$TRAVIS_BRANCH\"" > Cartfile 
# carthage update --use-ssh --platform iOS 
# time xcodebuild clean build -project StackViewLayout-Carthage-iOS.xcodeproj \
#     -scheme StackViewLayout-Carthage-iOS -sdk iphonesimulator15.2  \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=15.2' \
#     | xcpretty 
# cd ../../.. 

echo "===============================" 
echo " Pod lib lint"                   
echo "===============================" 
time bundle exec pod lib lint --allow-warnings

# echo "==========================================" 
# echo " Swift Package Manager: iOS Empty project " 
# echo "==========================================" 
# cd TestProjects/swift-package-manager/ios 
# rm -rf $DERIVED_DATA 
# rm -rf .build  
# rm Package.pins
# swift package show-dependencies --format json  
# time xcodebuild clean build -project StackViewLayout-Carthage-iOS.xcodeproj -scheme StackViewLayout-Carthage-iOS -sdk iphonesimulator15.2 \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2' \
#     | xcpretty 
# cd ../../.. 
# 
# #OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies'
# xcodebuild clean test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-macOS -sdk macosx10.15 
