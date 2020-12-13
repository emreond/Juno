# Juno

Logger for iOS platform which allows you to see/display all print logs on UI component while you are using the app. Cool right?

[![Swift Version][swift-image]][swift-url]


## How Does It Work:

Just initialize the Juno right after `didFinishLaunchWithOptions` function in AppDelegate and see the magic! (Of course write `print` in somewhere in your app :))

**How To Use It**

```
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ....
        
        #if DEBUG
        Juno()
        #endif
        return true
    }
    ```


[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
