#
#  Be sure to run `pod spec lint IpassFrameWork1.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "IpassFrameWork1"
  spec.version      = "0.0.1"
  spec.summary      = "Addition and substraction of numbers"
  spec.description  = "The mai feature of this skd Adding and Substrating of two numbers"

  spec.homepage     = "https://github.com/mobileexpert1/IpassFramework10"

 # spec.license      = "MIT (example)"
   spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Raman Rana" => "appsdev096@gmail.com" }
  # Or just: spec.author    = "Raman Rana"
  # spec.authors            = { "Raman Rana" => "appsdev096@gmail.com" }
  # spec.social_media_url   = "https://twitter.com/Raman Rana"

   spec.platform     = :ios
  # spec.platform     = :ios, "5.0"

  spec.ios.deployment_target = "14.0"


  spec.source       = { :git => "https://github.com/mobileexpert1/IpassFramework10.git", :tag => "#{spec.version}" }

  spec.source_files  =  "IpassFrameWork1/**/*.{h,m,swift}"
  #spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

    spec.swift_version = '4.0'
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

 # spec.requires_arc = true

 # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
