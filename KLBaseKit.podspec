#
# Be sure to run `pod lib lint KCoreKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KLBaseKit'
  s.version          = '0.2.3'
  s.summary          = '...'

  s.description      = <<-DESC
  ......
                       DESC

  s.homepage         = 'https://jobs.schwarz'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Markus Troßbach' => 'markus.trossbach@mail.schwarz' }
  s.source           = { :git => 'https://github.com/SchwarzIT/iosklbasekit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mtrossba'

  s.swift_version = '5.0'
  s.ios.deployment_target = '10.3'
  s.tvos.deployment_target = '10.2'
  #s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '4.3'
  s.requires_arc = true
  s.source_files = "KLBaseKit/**/*.{h,m,mm,c,ccp,hpp,swift}"

end
