DERIVED_DATA=${1:-/tmp/StackViewLayout}

set -e  &&
set -o pipefail  &&
rm -rf $DERIVED_DATA &&

echo "==============================="  &&
echo "StackViewLayout-iOS"              &&
echo "==============================="  &&
time xcodebuild build -project StackViewLayout.xcodeproj -scheme StackViewLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2'  \
   | xcpretty  &&

echo "==============================="  &&
echo "StackViewLayout-tvOS"             &&
echo "==============================="  &&
time xcodebuild build -project StackViewLayout.xcodeproj -scheme StackViewLayout-tvOS \
   -derivedDataPath $DERIVED_DATA -sdk appletvsimulator13.2 \
   -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=13.2' \
   | xcpretty  &&

echo "==============================="  &&
echo "StackViewLayoutExample"           &&
echo "==============================="  &&
time xcodebuild build -workspace StackViewLayout.xcworkspace -scheme StackViewLayoutExample \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2'  \
   | xcpretty  &&

time xcodebuild build -workspace StackViewLayout.xcworkspace -scheme StackViewLayoutExample \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.2 \
   -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   | xcpretty  &&

echo "==============================="  &&
echo "iOS unit test"                    &&
echo "==============================="  &&
time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.2 \
   -destination 'platform=iOS Simulator,name=iPhone 7,OS=11.4'  \
   | xcpretty  &&
    
time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=12.2' \
   | xcpretty  &&

time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-iOS \
   -derivedDataPath $DERIVED_DATA -sdk iphonesimulator13.2 \
   -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2' \
   | xcpretty  &&

# echo "===============================" &&
# echo "tvOS unit test"                  && 
# echo "===============================" &&
# time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-tvOS \
#    -derivedDataPath $DERIVED_DATA -sdk appletvsimulator13.2 \
#    -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=13.2' \
#    | xcpretty &&

# time  xcodebuild build test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-tvOS \
#    -derivedDataPath $DERIVED_DATA -sdk appletvsimulator13.2 \
#    -destination 'platform=tvOS Simulator,name=Apple TV 4K,OS=13.2' \
#    | xcpretty &&

# echo "===============================" 
# echo "macOS unit test"                 
# echo "==============================="  
# time  xcodebuild clean test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-macOS \
#    -derivedDataPath $DERIVED_DATA -sdk macosx10.15 \
#    | xcpretty 

# echo "==============================="  &&
# echo " Cocoapods: iOS Empty project"    &&
# echo "==============================="  &&
# cd TestProjects/cocoapods/ios  &&
# rm -rf $DERIVED_DATA  &&
# pod install  &&
# time xcodebuild clean build -workspace StackViewLayout-iOS.xcworkspace -scheme StackViewLayout-iOS \
#     -sdk iphonesimulator13.2  -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2' \
#     | xcpretty  &&
# cd ../../..  &&

# echo "==============================="  &&
# echo " Cocoapods: tvOS Empty project"   &&
# echo "==============================="  &&
# cd TestProjects/cocoapods/tvos  &&
# rm -rf $DERIVED_DATA  &&
# pod install  &&
# time xcodebuild clean build -workspace StackViewLayout-tvOS.xcworkspace -scheme StackViewLayout-tvOS \
#     -sdk appletvsimulator13.2 -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=tvOS Simulator,name=Apple TV,OS=13.2' \
#     | xcpretty  &&
# cd ../../..  &&


# echo "==============================="  &&
# echo " Carthage: iOS Empty project"     &&
# echo "==============================="  &&
# cd TestProjects/carthage/ios  &&
# rm -rf $DERIVED_DATA  &&
# rm Cartfile  &&
# echo "git \"$TRAVIS_BUILD_DIR\" \"$TRAVIS_BRANCH\"" > Cartfile  &&
# carthage update --use-ssh --platform iOS  &&
# time xcodebuild clean build -project StackViewLayout-Carthage-iOS.xcodeproj \
#     -scheme StackViewLayout-Carthage-iOS -sdk iphonesimulator13.2  \
#     -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2' \
#     | xcpretty  &&
# cd ../../..  &&

echo "==============================="  &&
echo " Pod lib lint"                    &&
echo "==============================="  &&
time bundle exec pod lib lint --allow-warnings

# echo "==========================================" 
# echo " Swift Package Manager: iOS Empty project " 
# echo "==========================================" 
# cd TestProjects/swift-package-manager/ios 
# rm -rf $DERIVED_DATA 
# rm -rf .build  
# rm Package.pins
# swift package show-dependencies --format json  
# time xcodebuild clean build -project StackViewLayout-Carthage-iOS.xcodeproj -scheme StackViewLayout-Carthage-iOS -sdk iphonesimulator13.2  -derivedDataPath $DERIVED_DATA \
#     -destination 'platform=iOS Simulator,name=iPhone 8,OS=13.2' \
#     | xcpretty 
# cd ../../.. 
# 
# #OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies'
# xcodebuild clean test -workspace StackViewLayout.xcworkspace -scheme StackViewLayout-macOS -derivedDataPath $DERIVED_DATA  -sdk macosx10.15 