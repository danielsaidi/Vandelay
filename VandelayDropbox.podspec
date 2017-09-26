Pod::Spec.new do |s|
  s.name             = 'VandelayDropbox'
  s.version          = '0.5.0'
  s.summary          = 'Vandelay is an iOS importer/exporter.'

  s.description      = <<-DESC
VandelayDropbox adds Dropbox support to Vandelay. With VandelayDropbox you
can export to and import from a Dropbox app folder.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'VandelayDropbox/Classes/**/*'
  
  s.dependency 'SwiftyDropbox'
  s.dependency 'Vandelay'
end
