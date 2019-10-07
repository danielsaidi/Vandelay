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

Vandelay is a Swift-based iOS importer/exporter. It supports `Codable`, strings and data and comes with built-in support for exporting and importing strings/data to/from a bunch of data sources.


## Installation

### Swift Package Manager

The easiest way to add Vandelay to your project is to use Swift Package Manager:
```
.package(url: "git@github.com:danielsaidi/Vandelay.git" ...)
```

### CocoaPods

```ruby
pod "Vandelay"
```

### Carthage

```ruby
github "danielsaidi/Vandelay"
```

### Manual installation

To add `Vandelay` to your app without a dependency manager, clone this repository, add `Vandelay.xcodeproj` to your project and `Vandelay.framework` as an embedded app binary and target dependency.


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


## QR Code support

You can add QR code scanning support with [VandelayQR][VandelayQR]. It lets you import data by scanning QR codes.


## Dropbox Support

You can add Dropbox support with [VandelayDropbox][VandelayDropbox]. It lets you export and import data to/from Dropbox.


## Demo App

This repo contains a demo app that lets you export/import todo items (strings) and photos (data). To run the demo app, open and run the `Vandelay.xcodeproj` project.


## Contact me

I hope you like this library. Feel free to reach out if you have questions or if
you want to contribute in any way:

* E-mail: [daniel.saidi@gmail.com][Email]
* Twitter: [@danielsaidi][Twitter]
* Web site: [danielsaidi.com][Website]


## License

Vandelay is available under the MIT license. See the LICENSE file for more info.

[Email]: mailto:daniel.saidi@gmail.com
[Twitter]: http://www.twitter.com/danielsaidi
[Website]: http://www.danielsaidi.com

[Carthage]: https://github.com/Carthage
[CocoaPods]: http://cocoapods.org
[GitHub]: https://github.com/danielsaidi/Vandelay
[Pod]: http://cocoapods.org/pods/Vandelay
[License]: https://github.com/danielsaidi/Vandelay/blob/master/LICENSE

[VandelayDropbox]: https://github.com/danielsaidi/VandelayDropbox
[VandelayQR]: https://github.com/danielsaidi/VandelayQr
