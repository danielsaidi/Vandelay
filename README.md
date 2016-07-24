![Vandelay logo](Assets/logo-900.png "Vandelay")

# Vandelay

[![CI Status](http://img.shields.io/travis/danielsaidi/Vandelay.svg?style=flat)](https://travis-ci.org/danielsaidi/Vandelay)
[![Version](https://img.shields.io/cocoapods/v/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![License](https://img.shields.io/cocoapods/l/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![Platform](https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)


## What is Vandelay?

Vandelay is an importer / exporter library for iOS. It can be used to import and export data in various
ways.

Vandelay currently supports:

**Exporting** to:

 - UIPasteboard
 - E-mail file attachment
 - Local file
 - Dropbox app folder

**Importing** from:

 - UIPasteboard
 - E-mail file attachment
 - Local file
 - Dropbox app folder

Vandelay comes with a couple of importers and exporters, some UI components as well as some core
functionality like serialization, file name generators, unique id generation etc.


### Exporting data

Vandelay exporters can implement the StringExporter or DataExporter protocols, or both. A string
exporter exports strings (duh), while a data exporter exports encoded NSData.

Since strings are platform-independent, use string exporters whenever possible. For instance, an
object or collection that can be serialized to JSON, should be exported with a string exporter.

Data exporters, however, can export any NSData serializable object, e.g. objects with properties
that become nil when being serialized. This exported data can only be imported on platforms that
support NSData, like iOS.


### Importing data

A Vandelay importer can either implement the StringImporter or DataImporter protocol, or both. A
string importer imports strings, while a data importer imports NSData.



## Dropbox

Vandelay comes with support for exporting to and importing from a Dropbox app folder. This means
that an app can use Vandelay and Dropbox to sync user data to the user's personal Dropbox folder.

Dropbox import and export requires a little setting up. First create a Dropbox developer account,
then create a Dropbox app for your app.  After that, follow Dropbox's install guide and tutorial:

- [Install Guide](https://www.dropbox.com/developers/documentation/swift#install)
- [Tutorial](https://www.dropbox.com/developers/documentation/swift#tutorial)

You can also check the Dropbox importer and exporter class files for more instructions on how to
setup Dropbox.



## Example Project

Vandelay comes with an example project that lets you export and import strings and data. You can
import and export todo list items as string data, and photos as NSData.

To run the example project, just clone the repo and run `pod install` from the Example directory.
You can then open the example app (use the generated workspace) and run the app.



## Installation


### Cocoapods

Vandelay is available through [CocoaPods](http://cocoapods.org). To install Vandelay, simply add
the following line to your Podfile:

```ruby
pod "Vandelay"
```


### Dropbox

Dropbox support is installed as a separate pod. To install VandelayDropbox, add this line to the
Podfile:

```ruby
pod "VandelayDropbox"
```



## Author

Daniel Saidi, daniel.saidi@gmail.com



## License

Vandelay is available under the MIT license. See the LICENSE file for more info.

