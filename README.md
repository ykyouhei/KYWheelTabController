# KYWheelTabController

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Version](http://img.shields.io/cocoapods/v/KYWheelTabController.svg?style=flat)](http://cocoadocs.org/docsets/KYWheelTabController/)
[![Pod Platform](http://img.shields.io/cocoapods/p/KYWheelTabController.svg?style=flat)](http://cocoadocs.org/docsets/KYWheelTabController/)
[![Pod License](http://img.shields.io/cocoapods/l/KYWheelTabController.svg?style=flat)](https://github.com/ykyohei/KYWheelTabController/blob/master/LICENSE)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)

`KYWheelTabController` is a subclass of UITabBarController.It displays the circular menu instead of UITabBar.


![sample.gif](./Images/sample.gif "sample.png")


## Installation

### CocoaPods

`KYWheelTabController ` is available on CocoaPods.
Add the following to your `Podfile`:

```ruby
pod 'KYWheelTabController'
```

### Manually
Just add the Classes folder to your project.


## Usage
It can be used in the same way as UITabBarController.
* `tabBarItem.title` is not support.
* `tabBarItem.imageInsets` is not support.
* `tabBarItem.badgeValue` is not support.

### Code

```Swift
import UIKit
import KYWheelTabController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let vc0 = UIViewController()
        vc0.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample0"),
            selectedImage: UIImage(named: "sample0_selected"))
        
        let vc1 = UIViewController()
        vc1.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample1"),
            selectedImage: UIImage(named: "sample1_selected"))
        
        let vc2 = UIViewController()
        vc2.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample2"),
            selectedImage: UIImage(named: "sample2_selected"))
        
        let vc3 = UIViewController()
        vc3.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "sample3"),
            selectedImage: UIImage(named: "sample3_selected"))
        
        let wheelTabController = KYWheelTabController()
        wheelTabController.viewControllers = [vc0, vc1, vc2, vc3]

        /* Customize
         // selected boardre color.
         wheelTabController.tintColor = UIColor.redColor()
        */
        
        window?.rootViewController = wheelTabController
 
        return true
    }
```

### Storyboard
 1. Set the `KYWheelTabController` to Custom Class of UITabBarController.

 ![sample2.gif](./Images/sample2.gif "sample2.gif")

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE). 