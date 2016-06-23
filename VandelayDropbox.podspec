#
# Be sure to run `pod lib lint Vandelay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VandelayDropbox'
  s.version          = '0.2.0'
  s.summary          = 'Vandelay is an importer/exporter for iOS.'

  s.description      = <<-DESC
VandelayDropbox adds Dropbox integrations to Vandelay and lets you export
strings, serialized JSON and encoded NSData to your app's Dropbox folder.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VandelayDropbox/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Vandelay' => ['Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftyDropbox', '~> 3.0.0'
  s.dependency 'Vandelay', '~> 0.2.0'
end
