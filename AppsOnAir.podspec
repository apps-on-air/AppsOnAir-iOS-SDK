#
# Be sure to run `pod lib lint AppsOnAir.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppsOnAir'
  s.version          = '0.1.5'
  s.summary          = 'AppsOnAir is library for managing app updates and its maintenance.'

  s.description      = 'AppsOnAir is library for managing app updates and its maintenance. It will handle from out web portal.'

  s.homepage         = 'https://doc.dev.appsonair.com/Mobile-Quickstart/ios-sdk-setup'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'devtools-logicwind' => 'devtools@logicwind.com' }
  s.source           = { :git => 'https://github.com/apps-on-air/AppsOnAir-iOS-SDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'AppsOnAirSDK/Classes/**/*'
  s.resources = ['AppsOnAirSDK/Assets/AppUpdate.storyboard']
  
end
