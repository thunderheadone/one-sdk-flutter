#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'one_sdk_flutter'
  s.version          = '1.0.0'
  s.summary          = 'One Flutter Plugin for the ONE SDK for iOS and Android'
  s.description      = <<-DESC
                        One Flutter Plugin for the ONE SDK for iOS and Android
                       DESC
  s.homepage         = 'http://thunderhead.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Thunderhead, Inc.' => 'onesupport@thunderhead.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Thunderhead'
  s.static_framework = true
  s.ios.deployment_target = '8.0'
end

