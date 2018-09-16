![Vandelay logo](Assets/logo-900.png "Vandelay")

# Vandelay

[![CI Status](http://img.shields.io/travis/danielsaidi/Vandelay.svg?style=flat)](https://travis-ci.org/danielsaidi/Vandelay)
[![Version](https://img.shields.io/cocoapods/v/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![License](https://img.shields.io/cocoapods/l/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![Platform](https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)


## About

Vandelay is an importer/exporter for iOS (mind the pun). It is written
in Swift 4 and comes with built-in support for exporting and importing
strings and data to/from a bunch of data sources. It supports `Codable`
types as well as basic string and data.


## Installation

### Cocoapods

To install Vandelay with [CocoaPods](http://cocoapods.org) add this to
your `Podfile`, then run `pod install`:

```ruby
pod "Vandelay"
```

You can add additional support for Dropbox and QR codes by adding more
lines to the `Podfile`: 

```ruby
pod "VandelayDropbox"
```

```ruby
pod "VandelayQr"
```

### Carthage

To install Vandelay with [Carthage](https://github.com/Carthage), just
add this to your `Cartfile`, then run `carthage update --platform iOS`:

```ruby
github "danielsaidi/Vandelay"
```

This will download and build all `Vandelay` frameworks including every
external dependency (`VandelayDropbox` depends on `SwiftDropbox` which
depends on `Alamofire`, `VandelayQr` depends on `QrCodeReader`), so it
will take a little time.

Once Carthage has built all frameworks, you can add every required one
to the app. This involves a little more work than when using CocoaPods,
but you will then have pre-built frameworks.


## Exporting data

Vandelay lets you export strings, data and `Encodable` types, by using
any of its built-in exporters. You can also extend it with custom ones.

Vandelay comes with the following built-in exporters:

- `EmailExporter` - exports `strings` & `data` as email attachments
- `FileExporter` - exports `strings` & `data` to local files
- `MessageExporter` - exports `strings` & `data` as message attachments
- `PasteboardExporter` - exports `strings` to the pasteboard

If you add `VandelayDropbox`, you get access to the following exporter:

- `DropboxExporter` - exports `strings` & `data` to Dropbox

You should probably use string exporters whenever possible. Use a data
exporter when you only have `Data` or when a type can't be serialized.


## Importing data

Vandelay lets you import strings, data and `Decodable` types, by using
any of its built-in importers. You can also extend it with custom ones.

Vandelay comes with the following built-in importers:

- `FileExporter` - imports `strings` & `data` from local files
- `PasteboardExporter` - imports `strings` from the pasteboard
- `UrlExporter` - imports `strings` & `data` from custom urls

If you add `VandelayDropbox`, you get access to the following importer:

- `DropboxImporter` - imports `strings` & `data` from Dropbox

If you add `VandelayQr`, you get access to the following importer:

- `QrCodeImporter [STRING|DATA]` - imports by scanning a QR code

When importing, the same goes as when exporting: data is more powerful,
but strings are more universal.


## Dropbox Support

Vandelay comes with additional Dropbox support. This means that an app
can use Vandelay to sync data to a user's personal Dropbox app folder.

To use these features in your app, you must create a Dropbox developer
account as well as a Dropbox app for your app. This guide explains how:

- [Install Guide](https://www.dropbox.com/developers/documentation/swift#install)
- [Tutorial](https://www.dropbox.com/developers/documentation/swift#tutorial)

Check out how the demo app gets Dropbox ready for use. Basically, your
app must setup Dropbox integration when started then handle any return
url that are triggered when Dropbox redirects the user back to the app.
Also, your app must add a few keys to `Info.plist`.

In the demo app, you just have to add your Dropbox app ID to the local
`Accounts.plist` file, then select the app target, select the info tab
and insert the same app ID under `URL Types`.


## QR Code support

Vandelay comes with additional QR code support. This means that an app
can use Vandelay to import data by letting the user scan a QR code.

To use this feature, make sure to specify a `NSCameraUsageDescription`
text in Info.plist. Otherwise, the app will crash. Also make sure that
the app can access the scanned url. The demo does this by allowing any
urls to be imported. In a real world app, allowing arbitary urls isn't
probably a good idea :)


## Example Project

Vandelay comes with an example project that lets you export and import
todo lists (strings) and photos (data).

Before you can run the example app, you have to install `Carthage` and
run `carthage update --platform iOS`. This will setup all dependencies
and prepare the app. You can then open the project and run the app.

For QR codes, you can use the built-in `QrCodeGenerator` to generate a
scannable QR code for any url you have exported data to. You will then
be able to scan that code to import data into the app.


## Versioning

Versions < 1.0.0 will have breaking changes between minor versions, so
Vandelay 0.3.0 will probably not be compatible with Vandelay 0.2.0 etc.


## Author

Daniel Saidi, daniel.saidi@gmail.com


## License

Vandelay is available under the MIT license. See the LICENSE file for more info.

