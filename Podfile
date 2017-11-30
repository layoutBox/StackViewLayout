use_frameworks!
platform :ios, "8.0"

workspace 'StackLayout.xcworkspace'

target 'StackLayout' do
  project 'StackLayout.xcodeproj'

  pod 'PinLayout'  
end

target 'StackLayoutTests' do
  project 'StackLayout.xcodeproj'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'StackLayoutExample' do
  platform :ios, "8.0"
  project 'Example/StackLayoutExample.xcodeproj'

  pod 'StackLayout', :path => './'
  pod 'PinLayout'

  # Debug only
  pod 'Reveal-SDK', '~> 10', :configurations => ['Debug']
  pod 'SwiftLint'
end
