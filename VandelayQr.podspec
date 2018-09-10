Pod::Spec.new do |s|
  s.name             = 'VandelayQr'
  s.version          = '0.6.0'
  s.summary          = 'VandelayQr is a QR code extension to Vandelay.'

  s.description      = <<-DESC
VandelayQr adds QR code support to Vandelay. You can use it to import
data by scanning QR codes.
                       DESC

  s.homepage         = 'https://github.com/danielsaidi/vandelay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/vandelay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/danielsaidi'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Vandelay/VandelayQr/**/*'
  
  s.dependency 'QRCodeReader.swift'
  s.dependency 'Vandelay'
end
