#
#  Be sure to run `pod spec lint Taylor.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "StackViewLayout"
  spec.version      = "0.1.7"
  spec.summary      = "StackViewLayout is a UIStackView replacement that don't rely on auto layout"
  #spec.description  = ""

  spec.homepage     = "https://github.com/layoutBox/StackViewLayout/"
  spec.license      = "MIT license"
  spec.author       = { 
    "Luc Dion" => "luc_dion@yahoo.com"
  }
  
  spec.ios.deployment_target  = '8.0'
  spec.ios.frameworks         = 'Foundation', 'CoreGraphics', 'UIKit'
  
  spec.tvos.deployment_target = '9.0'
  spec.tvos.frameworks        = 'Foundation', 'CoreGraphics', 'UIKit'

  spec.source       = { :git => "https://github.com/layoutBox/StackViewLayout.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.swift"
end
