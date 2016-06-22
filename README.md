# Vandelay

[![CI Status](http://img.shields.io/travis/Daniel Saidi/Vandelay.svg?style=flat)](https://travis-ci.org/Daniel Saidi/Vandelay)
[![Version](https://img.shields.io/cocoapods/v/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![License](https://img.shields.io/cocoapods/l/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)
[![Platform](https://img.shields.io/cocoapods/p/Vandelay.svg?style=flat)](http://cocoapods.org/pods/Vandelay)

![Vandelay logo](assets/logo-900.png "Vandelay")


## What is Vandelay?

Vandelay is a data importer/exporter for iOS. It can be used to import (soon) and export data in
various ways. Currently, it supports:

 - UIPase
 - Copy to and paste from the pasteboard
 - Send as an e-mail attachment
 - Send in a message
 - Save to and import from an Dropbox application folder

Vandelay comes with a couple of importers and exporters, as well as some ui components that make
using Vandelay a breeze.


### Importing data

This part of Vandelay is still under development.


### Exporting data

Vandelay can be used to export strings (e.g. JSON serialized data) or more complex data (such as
objects with large data properties).

A Vandelay exporter can either implement the StringExporter or DataExporter protocol, or both. A
string exporter can export strings, while a data exporter can export NSData.

Since strings are platform-independent, use string exporters whenever possible. For instance, an
object or collection that can be serialized to JSON, should be exported with a string exporter.

Data exporters, however, can be used to export more complex data, like images, NSData or objects
with such properties (for instance, cards in my wallet app consist of two images and a name). It
is harder to setup, however, and the result can only be used with software that supports NSData.


## Dropbox

Vandelay comes with support for importing from (well, soon) and exporting to Dropbox. This means
that your app can sync user data to the user's personal Dropbox folder.

To use the Dropbox importer and exporter, first create a Dropbox developer account and create an
app in the Dropbox developer portal. When, follow the instructions under "Install".




## Example Project

To run the example project, just clone the repo and run `pod install` from the Example directory.
You can then open the example app (use the generated workspace) and run the app.


## Requirements

Vandelay requires no additional components, if you want to export and import data in basic ways.





## Installation

Vandelay is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Vandelay"
```

### Dropbox





## Author

Daniel Saidi, daniel.saidi@gmail.com


## CocoaPods

To lint the project, run `pod lib lint` resp. `pod spec link Vandelay.podspec`.

To verify that the correct files are pulled from GitHub, type `cd ~/Library/Caches/CocoaPods/Pods`
then type `open .`. Verify that the content in the Vandelay folders are valid. To clean the cache,
run `pod cache clean Vandelay`.


## License

Vandelay is available under the MIT license. See the LICENSE file for more info.
