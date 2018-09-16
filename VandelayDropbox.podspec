Pod::Spec.new do |s|
  s.name             = 'VandelayDropbox'
  s.version          = '0.6.0'
  s.summary          = 'VandelayDropbox is a Dropbox extension to Vandelay.'

  s.description      = <<-DESC
VandelayDropbox adds Dropbox support to Vandelay. You can use it to export
and import data to/from a Dropbox app folder.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'VandelayDropbox/**/*'
  
  s.dependency 'SwiftyDropbox'
  s.dependency 'Vandelay'
end
