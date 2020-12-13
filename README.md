# Juno

Logger for iOS platform which allows you to see/display all print logs on UI component while you are using the app. Cool right?

[![Swift Version][swift-image]][swift-url]

## Integration

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `Juno` by adding it to your `Podfile`:

```ruby
platform :ios, '11.0'
use_frameworks!

target 'MyApp' do
  pod 'Juno', :git => 'https://github.com/emreond/Juno.git', :tag => '0.0.1'
end
```
Run `pods install` or `pods update` to intagrate pods with your project.


## How Does It Work:

Just initialize the Juno just before `didFinishLaunchWithOptions` function return in AppDelegate and see the magic! (Of course write `print` in somewhere in your app :))

**How To Use It**

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
        
    let bounds = UIScreen.main.bounds
    window = UIWindow(frame: bounds)
    let mainController = ViewController()
    window?.rootViewController = UINavigationController(rootViewController: mainController)
    window?.makeKeyAndVisible()

    #if DEBUG
    Juno()
    #endif
    return true
}
    
 ```
**How To Run Example**

Just select `JunoExample` scheme and hit run!

[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
