Pod::Spec.new do |s|
  s.name             = 'Vandelay'
  s.version          = '0.7.0'
  s.summary          = 'Vandelay is an iOS importer/exporter.'

  s.description      = <<-DESC
Vandelay is a Swift library that can be used to import and export
sting and data to/from iOS apps. It supports strings, Codable and
Data (to be used for more complex objects, image data etc.). 
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Vandelay/**/*.{swift}'

end
