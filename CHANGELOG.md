# Vandelay Changelog


## 0.6.0

This version migrates Vandelay to Swift 4 and adds Codable support. It
is very different from the previous 0.5.0 version.

Since Vandelay will now use Swift´s built in coding capabilities, some
features are no longer needed. The `Encoding` has therefore been moved
to my util library iExtra, which can be found [here](https://github.com/danielsaidi/iExtra).

I have also removed all UI components, like the exporter alert. It's a
lot easier and cleaner to implement an exporter picker yourself.

All in all, there are a lot of changes in this version. Do not compare
it with the old one.