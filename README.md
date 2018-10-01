<p align="center">
    <img src ="Assets/logo-900.png" width="450" alt="Vandelay logo" />
</p>


# Vandelay

[![Version](https://badge.fury.io/gh/danielsaidi%2FVandelay.svg?style=flat)](http://badge.fury.io/gh/danielsaidi%2FVandelay)
[![Carthage](https://img.shields.io/badge/carthage-supported-green.svg?style=flat)](github)
[![CocoaPods](https://img.shields.io/cocoapods/v/Vandelay.svg?style=flat)](pod)
![Platform](https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat)
[![License](https://badges.frapsoft.com/os/mit/mit.svg?style=flat&v=102)](https://github.com/ellerbrock/open-source-badge/)


## About

Vandelay is an iOS importer/exporter. It is written in Swift and comes
with built-in support for exporting and importing strings/data to/from
a bunch of data sources. It supports `Codable` types, strings and data.


## Installation

### Cocoapods

If you use [CocoaPods](cocoapods), add this line to your `Podfile` and
run `pod install`:

```ruby
pod "Vandelay"
```

### Carthage

If you use [Carthage](carthage), add this line to your `Cartfile` then
run `carthage update --platform iOS`:

```ruby
github "danielsaidi/Vandelay"
```


## Exporting data

Vandelay lets you export strings, data and `Encodable` types, by using
any of its built-in exporters. You can also extend it with custom ones.

Vandelay comes with the following built-in exporters:

- `EmailExporter` - exports `strings` & `data` as email attachments
- `FileExporter` - exports `strings` & `data` to local files
- `MessageExporter` - exports `strings` & `data` as message attachments
- `PasteboardExporter` - exports `strings` to the pasteboard

You should probably use string exporters whenever possible. Use a data
exporter when you only have `Data` or when a type can't be serialized.


## Importing data

Vandelay lets you import strings, data and `Decodable` types, by using
any of its built-in importers. You can also extend it with custom ones.

Vandelay comes with the following built-in importers:

- `FileExporter` - imports `strings` & `data` from local files
- `PasteboardExporter` - imports `strings` from the pasteboard
- `UrlExporter` - imports `strings` & `data` from custom urls

When importing, the same goes as when exporting: data is more powerful,
but strings are more universal.


## Dropbox Support

You can add Dropbox code support to Vandelay with [VandelayDropbox](vandelaydropbox).


## QR Code support

You can add QR code support to Vandelay with [VandelayQR](vandelayqr).


## Example Project

Vandelay comes with an example project that lets you export and import
todo lists (strings) and photos (data).

Before you can run the example app, you have to install `Carthage` and
run `carthage update --platform iOS`. This will setup all dependencies
and prepare the app. You can then open the project and run the app.


## Versioning

Versions < 1.0.0 will have breaking changes between minor versions, so
Vandelay 0.8.0 will probably not be compatible with 0.7.0 etc.


## Author

Daniel Saidi, daniel.saidi@gmail.com


## License

Vandelay is available under the MIT license. See the LICENSE file for more info.


[carthage]: https://github.com/Carthage
[cocoapods]: http://cocoapods.org
[github]: https://github.com/danielsaidi/Vandelay
[pod]: http://cocoapods.org/pods/Vandelay
[vandelaydropbox]: https://github.com/danielsaidi/VandelayDropbox
[vandelayqr]: https://github.com/danielsaidi/VandelayQr