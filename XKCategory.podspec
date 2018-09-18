#
# Be sure to run `pod lib lint XKCategory.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XKCategory'
  s.version          = '1.0.0'
  s.summary          = '日常用到的分类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '日常开发经常用到的分类'

  s.homepage         = 'https://github.com/kunhum/XKCategory'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kunhum' => 'kunhum@163.com' }
  s.source           = { :git => 'https://github.com/kunhum/XKCategory.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

#s.source_files = 'XKCategory/Classes/XKCategory/*.{h,m}'
  
  # s.resource_bundles = {
  #   'XKCategory' => ['XKCategory/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.subspec 'NSDate+xkCategory' do |dateCategory|
      dateCategory.source_files = 'XKCategory/Classes/XKCategory/NSDate+xkCategory/*.{h,m}'
      dateCategory.public_header_files = 'XKCategory/Classes/XKCategory/NSDate+xkCategory/*.h'
  end
  
  s.subspec 'NSString+xkCategory' do |stringCategory|
      stringCategory.source_files = 'XKCategory/Classes/XKCategory/NSString+xkCategory/*.{h,m}'
      stringCategory.public_header_files = 'XKCategory/Classes/XKCategory/NSString+xkCategory/*.h'
      
      #s.subspec 'MD5SHA1' do |mD5SHA1|
          # mD5SHA1.source_files = 'XKCategory/Classes/XKCategory/NSString+xkCategory/MD5SHA1/*.{h,m}'
          #mD5SHA1.public_header_files = 'XKCategory/Classes/XKCategory/NSString+xkCategory/MD5SHA1/*.h'
          
          #s.subspec 'GTMBase64' do |gTMBase64|
          # gTMBase64.source_files = 'XKCategory/Classes/XKCategory/NSString+xkCategory/MD5SHA1/GTMBase64/*.{h,m}'
          # gTMBase64.public_header_files = 'XKCategory/Classes/XKCategory/NSString+xkCategory/MD5SHA1/GTMBase64/*.h'
              
              #end
              # end
      
  end
  
end
