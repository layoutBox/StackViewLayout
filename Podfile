source 'https://cdn.cocoapods.org/'
use_frameworks!

workspace 'StackViewLayout.xcworkspace'

#target 'StackViewLayout-iOS' do
#  project 'StackViewLayout.xcodeproj'
#end

target 'StackViewLayoutTests-iOS' do
  project 'StackViewLayout.xcodeproj'
  platform :ios, "9.0"
  pod 'PinLayout'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'StackViewLayoutTests-tvOS' do
  project 'StackViewLayout.xcodeproj'
  platform :tvos, "9.0"
  pod 'PinLayout'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'StackViewLayoutExample' do
  project 'Example/StackViewLayoutExample.xcodeproj'
  platform :ios, "9.0"
  
  pod 'StackViewLayout', :path => './'
  pod 'PinLayout'
  pod 'FlexLayout'  

  # Debug only
  # pod 'Reveal-SDK', '~> 17', :configurations => ['Debug']
  pod 'SwiftLint'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'yes'
        end
    end
end