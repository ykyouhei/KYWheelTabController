Pod::Spec.new do |s|
  s.name         = "KYWheelTabController"
  s.version      = "2.1.1"
  s.summary      = "KYWheelTabController is a subclass of UITabBarController.It displays the circular menu instead of UITabBar."
  s.homepage     = "https://github.com/yaron3"
  s.license      = "MIT"
  s.author       = { "Yaron Jackoby" => "yaronj3@gmail.com" }
  s.social_media_url   = "https://twitter.com/kyo__hei"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yaron3/KYWheelTabController.git", :tag => s.version.to_s }
  s.source_files = "KYWheelTabController/Classes/**/*.swift"
  s.resources    = "KYWheelTabController/Resources/*"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end
