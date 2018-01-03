use_frameworks!
platform :ios, "9.0"

workspace 'StackLayout.xcworkspace'

target 'StackLayout' do
  project 'StackLayout.xcodeproj'

  pod 'PinLayout'  
  #pod 'PinLayout', :path => '../PinLayout'
end

target 'StackLayoutTests' do
  project 'StackLayout.xcodeproj'
  pod 'PinLayout'
  #pod 'PinLayout', :path => '../PinLayout'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'StackLayoutExample' do
  project 'Example/StackLayoutExample.xcodeproj'

  pod 'StackLayoutView', :path => './'
  pod 'PinLayout'
  #pod 'PinLayout', :path => '../PinLayout'
  pod 'FlexLayout'  

  # Debug only
  pod 'Reveal-SDK', '~> 10', :configurations => ['Debug']
  pod 'SwiftLint'
end
