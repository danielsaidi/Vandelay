<p align="center">
    <img src ="Assets/logo-900.png" width="450" alt="Vandelay logo" />
</p>

<p align="center">
    <a href="https://github.com/danielsaidi/Vandelay">
        <img src="https://badge.fury.io/gh/danielsaidi%2FVandelay.svg?style=flat" alt="Version" />
    </a>
    <img src="https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat" alt="Platform" />
    <img src="https://img.shields.io/badge/Swift-5.1-orange.svg" alt="Swift 5.1" />
    <img src="https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102" alt="License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/badge/contact-@danielsaidi-blue.svg?style=flat" alt="Twitter: @danielsaidi" />
    </a>
</p>


## About

Vandelay is an iOS importer/exporter. It supports `Codable` types, strings and data and comes with built-in support for exporting and importing strings/data to/from a bunch of data sources.


## Installation

### Swift Package Manager

In Xcode 11 and later, the easiest way to add Vandelay to your project is to use Swift Package Manager:
```
.package(url: "git@github.com:danielsaidi/Vandelay.git" ...)
```

### CocoaPods

If you use [CocoaPods](CocoaPods), add this line to your `Podfile` and run `pod install`:
```ruby
pod "Vandelay"
```

### Carthage

If you use [Carthage](carthage), add this line to your `Cartfile` then run `carthage update --platform iOS`:
```ruby
github "danielsaidi/Vandelay"
```

### Manual installation

To add `Vandelay` to your app without a dependency manager, clone this repository and place it somewhere on disk, then add `Vandelay.xcodeproj` to the project and `Vandelay.framework` as an embedded app binary and target dependency.


## Exporting data

Vandelay uses `exporters` to let you export strings, data and `Encodable`.

Vandelay comes with the following built-in exporters:

- `EmailExporter` - exports `strings` & `data` as email attachments
- `FileExporter` - exports `strings` & `data` to local files
- `MessageExporter` - exports `strings` & `data` as message attachments
- `PasteboardExporter` - exports `strings` to the pasteboard

You can extend Vandelay with custom exporters as well.

Use `string` exporters if you want platform-agnostic, readable exports. Use a `data` exporters when you only have `Data` or when a type can't be serialized.


## Importing data

Vandelay uses `importers` to let you import strings, data and `Decodable` types.

Vandelay comes with the following built-in importers:

- `FileExporter` - imports `strings` & `data` from local files
- `PasteboardExporter` - imports `strings` from the pasteboard
- `UrlExporter` - imports `strings` & `data` from custom urls

You can extend Vandelay with custom importers as well.

When importing, the same goes as when exporting: data is more powerful, but strings are more universal.


## Dropbox Support

You can add Dropbox support with [VandelayDropbox](VandelayDropbox). It lets you export and import data to/from Dropbox.


## QR Code support

You can add QR code scanning support with [VandelayQR](VandelayQR). It lets you import data by scanning QR codes.


## Demo App

Vandelay comes with an example app, that lets you export and import an easily managed collection of todo items (strings) and photos (data).


### Dropbox Support

The demo app has support for [VandelayDropbox](VandelayDropbox). It's disabled by default, but can be enabled with these steps:

* Add `github "danielsaidi/VandelayDropbox"` to `Cartfile`.
* Run `carthage update --platform iOS --cache-builds`
* Uncomment the Dropbox-specific lines in `AppDelegate.swift`
* Uncomment the Dropbox-specific lines in `ViewController+Export.swift`
* Uncomment the Dropbox-specific lines in `ViewController+Import.swift`
* Add each framework to `Build Phases / [Carthage] Copy Files`.

Before you can use [VandelayDropbox](VandelayDropbox), you must create a Dropbox developer account, create a Dropbox app then finally replace the Dropbox app key you find in `Accounts.plist` and `Info.plist` with your own app keys.


### QR Code Support

The example app has support for [VandelayQR](VandelayQR). To enable it, follow these steps:

* Add `github "danielsaidi/VandelayQr"` to `Cartfile`.
* Run `carthage update --platform iOS --cache-builds`
* Uncomment the QR-specific lines in `ViewController+Import.swift`
* Add each framework to `Build Phases / [Carthage] Copy Files`.

For QR codes, you can use the built-in `QrCodeGenerator` to generate a scannable QR code for any url you have exported data to. You can then run the example project from your phone and scan that code to import data into the app.


## Contact me

I hope you like this library. Feel free to reach out if you have questions or if
you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com](mailto:daniel.saidi@gmail.com)
* Twitter: [@danielsaidi](http://www.twitter.com/danielsaidi)
* Web site: [danielsaidi.com](http://www.danielsaidi.com)


## License

Vandelay is available under the MIT license. See the LICENSE file for more info.


[Carthage]: https://github.com/Carthage
[CocoaPods]: http://cocoapods.org
[GitHub]: https://github.com/danielsaidi/Vandelay
[Pod]: http://cocoapods.org/pods/Vandelay
[License]: https://github.com/danielsaidi/Vandelay/blob/master/LICENSE

[VandelayDropbox]: https://github.com/danielsaidi/VandelayDropbox
[VandelayQR]: https://github.com/danielsaidi/VandelayQr
