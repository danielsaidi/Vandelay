# Release Notes


## 0.9.4

This version makes Vandelay build on all platforms.


## 0.9.3

This version just updates external dependencies.


## 0.9.2

This version adds support for Swift 5.2 and bumps all test dependencies.


## 0.9.1

This version makes a url calculation function public.


## 0.9.0

This version adds support for Swift 5.1 and Swift Package Manager.


## 0.8.0

This version moves stuff around between Vandelay and its add-ons. This means that I have had some trial and error getting it to work, but the `0.8.1` version works with both CocoaPods and Carthage. I version bump `VandelayQr` and `VandelayDropbox` to `0.8.1` as well.

The add-ons no longer have their own demo projects, since this meant I had to duplicate code en-masse. I moved the demo code to this repo and disabled it for now, since I could not get Carthage to ignore building the example app, which had a bunch of private dependencies. I will add it as a GitHub issue for future fixing.


## 0.7.0

This version migrates Vandelay to Swift 4.2. For now, the tests do run and everything builds correctly, but the example app has problems with linking the frameworks correctly. I'll create a GitHub issue for this.


## 0.6.0

This version migrates Vandelay to Swift 4 and adds Codable support. It is very different from the previous 0.5.0 version.

Since Vandelay will now use Swift´s built in coding capabilities, some features are no longer needed. The `Encoding` has therefore been moved to my util library iExtra, which can be found [here](https://github.com/danielsaidi/iExtra).

I have also removed all UI components, like the exporter alert. It's a lot easier and cleaner to implement an exporter picker yourself.

All in all, there are a lot of changes in this version. Do not compare it with the old one.
