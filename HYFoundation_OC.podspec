#
# Be sure to run `pod lib lint HYFoundation_OC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYFoundation_OC'
  s.version          = '0.0.4'
  s.summary          = 'NSFoundation的方法扩展'
  s.description      = <<-DESC
对系统的 NSFoundation 框架的一些方法的封装，扩展了一些常用的方法
                       DESC
  s.homepage         = 'https://github.com/oceanfive/HYFoundation_OC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'oceanfive' => '849638313@qq.com' }
  s.source           = { :git => 'https://github.com/oceanfive/HYFoundation_OC.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'HYFoundation_OC/Classes/**/*'
end
