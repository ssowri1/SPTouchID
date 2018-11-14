#
# Be sure to run `pod lib lint SPTouchID.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SPTouchID'
  s.version          = '0.1.5'
  s.summary          = 'Make a portable biometric authentication of your application!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Make a portable biometric authentication of your application! through your pod also..
                       DESC

  s.homepage         = 'https://github.com/ssowri1/SPTouchID'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ssowri1' => 'ssowri1@gmail.com' }
  s.source           = { :git => 'https://github.com/ssowri1/SPTouchID.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SPTouchID/Classes/**/*'
  
   s.resource_bundles = {
     'SPTouchID' => ['SPTouchID/Assets/*.gif']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
