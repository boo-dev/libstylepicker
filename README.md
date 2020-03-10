# libstylepicker
a preference library recreating apple's light/dark mode switcher

# Setup

- Add `TWEAKNAME_LIBRARIES = stylepicker` to your Tweak's Makefile if needed

- Add `TWEAKNAMEPREFS_LIBRARIES = stylepicker` to your Pref's Makefile if needed

# Usage
```xml
<dict>
<key>cell</key>
<string>PSTableCell</string>
<key>cellClass</key>
<string>StylePickerTableViewCell</string>
<key>leftStyle</key>
<dict>
<key>image</key>
<string>left-image</string>
<key>label</key>
<string>Light</string>
</dict>
<key>rightStyle</key>
<dict>
<key>image</key>
<string>right-image</string>
<key>label</key>
<string>Dark</string>
</dict>
<key>default</key>
<integer>1</integer>
<key>defaults</key>
<string>com.your.bundleid</string>
<key>key</key>
<string>AppearanceStyle</string>
</dict>
    
    
