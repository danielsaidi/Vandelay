![Vandelay logo](Assets/logo-900.png "Vandelay")

# Vandelay

[![CI Status](http://img.shields.io/travis/danielsaidi/Vandelay.svg?style=flat)](https://travis-ci.org/danielsaidi/Vandelay)
[![Version](https://img.shields.io/cocoapods/v/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![License](https://img.shields.io/cocoapods/l/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![Platform](https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)


## What is Vandelay?

Vandelay is an importer / exporter library for iOS that can be used to
import and export data in various ways.



## Exporting data

Vandelay comes with a few string and data exporters. A string exporter
exports strings and serialized data (e.g. JSON), while a data exporter
exports encoded NSData.

Vandelay currently comes with the following string and data exporters:

 - `PasteboardExporter` - exports string to the pasteboard
 - `EmailExporter` - exports data and strings as email file attachment
 - `FileExporter` - exports data and strings to local files
 - `DropboxExporter` - exports data and strings to files on Dropbox

If you want to implement a custom exporter, implement the DataExporter
and/or StringExporter protocol. Since strings are platform-independent,
use string exporters whenever your data can be serialized.

Data exporters, however, can export NSData encodable objects that have
properties that cannot be serialized to strings, e.g. image properties.
However, since these exporters export to NSData, the exported data can
only be imported on platforms that support NSData.



## Importing data

Vandelay comes with a few string and data importers. A string importer
imports strings and serialized data (e.g. JSON), while a data importer
imports encoded NSData.

Vandelay currently comes with the following string and data importers:

 - `PasteboardImporter` - imports string from the pasteboard
 - `FileImporter` - imports data and strings from local files
 - `DropboxImporter` - imports data and strings from files on Dropbox

When importing data, the same logic goes as when exporting data - it's
best to use strings whenever possible, but NSData is way more powerful.



## UI helpers

To make exporting and importing data with Vandelay easier, you can use
the import and export alert controllers that come with the library.

The `ExportAlertController` and `ImportAlertController` classes can be
used to show the app user a list of exporter and importer options. Set
the delegate property of these classes to detect when the user selects
an exporter or importer, then export and import data using it.



## Dropbox

Vandelay comes with additional support for Dropbox export/import. This
means that an app can use Vandelay and Dropbox to sync data to the app
user's personal Dropbox folder, in a sub folder called `Apps`.

Dropbox import and export requires a little setting up. First create a
Dropbox developer account, then create a Dropbox app for your app. You
can then follow Dropbox's install guide and tutorial to get going:

- [Install Guide](https://www.dropbox.com/developers/documentation/swift#install)
- [Tutorial](https://www.dropbox.com/developers/documentation/swift#tutorial)

Basically, you must let the user give Dropbox permission to handle app
data, then take care of the Dropbox callback. The, once Dropbox is all
good to go, you can use the Dropbox importer and exporter classes.



## Example Project

Vandelay comes with an example project that lets you export and import
todo lists (strings) and photo albums (data).

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
Vandelay 0.3.0 will probably not be compatible with Vandelay 0.2.0.



## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

Vandelay is available under the MIT license. See the LICENSE file for more info.

