Pod::Spec.new do |s|
  s.name             = 'VandelayQr'
  s.version          = '0.4.7'
  s.summary          = 'Vandelay is an importer/exporter for iOS.'

  s.description      = <<-DESC
VandelayQr adds QR code functionality to Vandelay, and lets you import any
string or data by scanning a QR code.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'VandelayQr/Classes/**/*'
  
  s.dependency 'QRCodeReader.swift'
  s.dependency 'Vandelay'
end
