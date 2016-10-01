Pod::Spec.new do |s|
  s.name             = 'Vandelay'
  s.version          = '0.4.5'
  s.summary          = 'Vandelay is an importer/exporter for iOS.'

  s.description      = <<-DESC
Vandelay is an importer / exporter for iOS, that can be used to import and 
export data in various ways.

Vandelay supports exporting and importing strings, serialized JSON and iOS
encoded NSData (for more complex objects, image data etc.).

Vandelay versions <1.0.0 will have breaking changes between minor versions.
This means that 0.3.0 will not be compatible with 0.2.0, and so on.

                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Vandelay/Classes/**/*.{swift}'

end
