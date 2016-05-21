#
# Be sure to run `pod lib lint AutoImageFlipper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AutoImageFlipper'
  s.version          = '0.8.0'
s.summary          = 'Show an array of images scequetially, with fade in, move and fade out effects, beautifully.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Show an array of images scequetially, with fade in, move and fade out effects, beautifully.
It can be used as the background of UIViewControllers with fade, like many many hit applications.
                       DESC

  s.homepage         = 'https://github.com/sina-kh/Swift-Auto-Image-Flipper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SinaKH' => 'mr.sina.khalili@gmail.com' }
  s.source           = { :git => 'https://github.com/sina-kh/Swift-Auto-Image-Flipper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AutoImageFlipper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AutoImageFlipper' => ['AutoImageFlipper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
