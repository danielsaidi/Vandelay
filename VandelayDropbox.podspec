Pod::Spec.new do |s|
  s.name             = 'VandelayDropbox'
  s.version          = '0.4.0'
  s.summary          = 'Vandelay is an importer/exporter for iOS.'

  s.description      = <<-DESC
VandelayDropbox adds Dropbox integrations to Vandelay, and lets you export
strings, serialized JSON and encoded NSData to your app's Dropbox folder.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VandelayDropbox/Classes/**/*'
  
  s.dependency 'SwiftyDropbox', '~> 4.0.0'
  s.dependency 'Vandelay', '~> 0.4.0'
end
