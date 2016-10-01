![Vandelay logo](Assets/logo-900.png "Vandelay")

# Vandelay

[![CI Status](http://img.shields.io/travis/danielsaidi/Vandelay.svg?style=flat)](https://travis-ci.org/danielsaidi/Vandelay)
[![Version](https://img.shields.io/cocoapods/v/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![License](https://img.shields.io/cocoapods/l/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![Platform](https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)


## What is Vandelay?

Vandelay is a string and data importer/exporter for iOS. It comes with
built-in support for a few basic data sources and can be extended with
even more.



## Exporting data

Vandelay can export strings, serialized data (string) and encoded data. 
An exporter can implement StringExporter and DataExporter, to indicate
in which ways it can be used.

Vandelay currently comes with the following string and data exporters:

- `EmailExporter` - exports data and strings as email attachments
- `FileExporter` - exports data and strings to local files
- `MessageExporter` - exports data and strings as message attachments
- `PasteboardExporter` - exports string to the pasteboard

- `DropboxExporter` - exports data and strings to Dropbox

Since strings are platform-independent, use a string exporter whenever
your data can be serialized, e.g. to JSON

Data exporters can export Data encodable objects, which is good when a
class has properties that cannot be serialized, e.g. an image property.
However, encoded Data can only be imported on Apple platforms.



## Importing data

Vandelay can import strings, serialized data (string) and encoded data. 
An importer can implement StringImporter and DataImporter, to indicate
in which ways it can be used.

Vandelay currently comes with the following string and data importers:

 - `PasteboardImporter` - imports string from the pasteboard
 - `FileImporter` - imports data and strings from local files
 - `UrlImporter` - imports data and strings from any url

 - `DropboxImporter` - imports data and strings from Dropbox

When importing data, the same logic goes as when exporting data - it's
best to use strings whenever possible, but Data is way more powerful.



## UI helpers

To make exporting and importing data easier, Vandelay comes with handy
alert classes that can be used to show the app user a list of exporter
and importer options. Set the delegate of these classes to detect when
the user selects an exporter or importer, then use it to export/import.

Check out `ExportAlertController` and `ImportAlertController` for more
information.



## Dropbox

Vandelay comes with additional Dropbox support. This means that an app
can use Vandelay to sync data to a user's personal Dropbox.

To use these features, create a Dropbox developer account as well as a
Dropbox app for your app. If you do not know how, follow this guide:

- [Install Guide](https://www.dropbox.com/developers/documentation/swift#install)
- [Tutorial](https://www.dropbox.com/developers/documentation/swift#tutorial)

Check out how the demo app gets Dropbox ready for use. Basically, apps
must setup Dropbox integration when started and handle any return urls
when Dropbox redirects the user back to the app. Also, apps must add a
few keys to `Info.plist`, namely `CFBundleURLTypes` (db-<APP KEY>) and 
`LSApplicationQueriesSchemes`.



## Example Project

Vandelay comes with an example project that lets you export and import
todo lists (strings) and photos (data).

To run the example app, clone this repo and run `pod install` from the
Example directory. You can then open up the project (use the generated
workspace) and run the app.



## Installation


### Cocoapods

Vandelay is available through [CocoaPods](http://cocoapods.org/). Just
add the following line to your Podfile and run `pod install` to add it
to your project.

```ruby
pod "Vandelay"
```
 

### Dropbox

Dropbox support is added as a separate pod. To install VandelayDropbox,
just add the following line to your Podfile:

```ruby
pod "VandelayDropbox"
```



## Versioning

Versions < 1.0.0 will have breaking changes between minor versions, so
Vandelay 0.3.0 will probably not be compatible with Vandelay 0.2.0 etc.



## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

Vandelay is available under the MIT license. See the LICENSE file for more info.

