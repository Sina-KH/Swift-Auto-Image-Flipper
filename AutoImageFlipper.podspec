Pod::Spec.new do |s|
  s.name             = 'AutoImageFlipper'
  s.version          = '0.8.2'
s.summary          = 'Show an array of images scequetially, with fade in, move and fade out effects, beautifully.'

  s.description      = <<-DESC
Show an array of images scequetially, with fade in, move and fade out effects, beautifully.
It can be used as the background of UIViewControllers with fade, like many many hit applications.
                       DESC

  s.homepage         = 'https://github.com/sina-kh/Swift-Auto-Image-Flipper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SinaKH' => 'mr.sina.khalili@gmail.com' }
  s.source           = { :git => 'https://github.com/sina-kh/Swift-Auto-Image-Flipper.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/KH_Sina'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AutoImageFlipper/Classes/**/*'

  s.frameworks = 'UIKit'
end
