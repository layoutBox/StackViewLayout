use_frameworks!
platform :ios, "9.0"

workspace 'StackViewLayout.xcworkspace'

target 'StackViewLayout' do
  project 'StackViewLayout.xcodeproj'

  pod 'PinLayout'  
end

target 'StackViewLayoutTests' do
  project 'StackViewLayout.xcodeproj'
  pod 'PinLayout'

  pod 'Quick'
  pod 'Nimble', :inhibit_warnings => true
end

target 'StackViewLayoutExample' do
  project 'Example/StackViewLayoutExample.xcodeproj'

  pod 'StackViewLayout', :path => './'
  pod 'PinLayout'
  pod 'FlexLayout'  

  # Debug only
  pod 'Reveal-SDK', '~> 17', :configurations => ['Debug']
  pod 'SwiftLint'
end
