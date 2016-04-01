#
#  Be sure to run `pod spec lint SDWebImage+FSExtensions.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SDWebImage+FSExtensions"
  s.version      = "0.0.1"
  s.summary      = "SDWebImageExtensions for convenient use."
  s.description  = <<-DESC
			SDWebImageExtensions for convenient use, roundCorner image cutting and stored
                   DESC

  s.homepage     = "https://github.com/FasaMo/SDWebImageExtensions"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "FasaMo" => "Fasa_Mo@iCloud.com" }
  s.social_media_url   = "http://weibo.com/FasaMo"

#  s.source       = { :git => "https://github.com/FasaMo/SDWebImageExtensions.git", :tag => s.version }
  s.source	 = { :git => "/Users/fasamo/Documents/iOS/github/SDWebImageExtensions", :tag => s.version }
  s.source_files  = "SDWebImage+FSExtensions/*.{h,m}"
  s.requires_arc = true
  s.dependency "SDWebImage", "~> 3.7"

end
