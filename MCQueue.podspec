#
# Be sure to run `pod lib lint MCQueue.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MCQueue'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MCQueue.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/CoderZhenLee/MCQueueView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yixiaochuan' => 'yixiaochuan@micous.com' }
  s.source           = { :git => 'https://github.com/CoderZhenLee/MCQueueView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MCQueue/Classes/**/*'
  
  s.subspec 'Base' do |ss|
      ss.source_files = 'MCQueue/Base/*'
  end
  
  s.subspec 'XenLive' do |ss|
      ss.source_files = 'MCQueue/XenLive/**/*'
  end
  
  # s.resource_bundles = {
  #   'MCQueue' => ['MCQueue/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
