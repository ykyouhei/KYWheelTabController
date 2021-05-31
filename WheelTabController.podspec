Pod::Spec.new do |s|
  s.name         = "WheelTabController"
  s.version      = "2.1.1"
  s.summary      = "KYWheelTabController is a subclass of UITabBarController.It displays the circular menu instead of UITabBar."
  s.homepage     = "https://github.com/yaron3/KYWheelTabController"
  s.license      = "MIT"
  s.author       = { "Yaron Jackoby" => "yaronj3@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yaron3/KYWheelTabController.git" }
  s.source_files = "KYWheelTabController/Classes/**/*.swift"
  s.resources    = "KYWheelTabController/Resources/*"
  s.requires_arc = true
  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
end
