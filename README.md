# VAST Parser for Swift (VAST 4.1)
[![Swift Version](https://img.shields.io/badge/Swift-5.0.x-orange.svg)]()

This is simple VAST parser with Swift.
[VAST](https://www.iab.com/guidelines/digital-video-ad-serving-template-vast/) is Digital Video Ad Serving Template defined by iAB.  
To follow this format, Ad Server and Client can communicate.  
Client prepare player based on VAST data.

## How to use
Please check Unit Test, Unit Test covers iAB samples
This is an exmaple code

### Use string
```swift
let vastParser = VastParser(contents: "")
let success = vastParser.parse()
```

### Use data
```swift
let vastParser = VastParser(contents: Data())
let success = vastParser.parse()
```

### Get VAST data

Basically, this VAST Parser follows just XML structure.  
Not organized data level.  
For more details, please read Unit Test.  
It's easy to understand where you want to get

```swift
let inLine = vastParser.vast.vastAd?.vastInline // InLine
let creative = vastParser.vast.vastAd?.vastInline?.creatives.creative[0]
```

### Name Chage
Some VAST arrtibute and data name is not accept for Swift, so need to change several.

ex)  
id -> xxxxId (mediafileId)
inline -> vastInLine


## Not Support
* Old Version VAST under 4.0
* Extension, CreativeExtension (will support next version)


## About Unit Test
Unit Test data is [iAB VAST Sample](https://github.com/InteractiveAdvertisingBureau/VAST_Samples/tree/master/VAST%204.1%20Samples)

## VAST XML structure
VAST structure ref is from [iAB Document](https://iabtechlab.com/wp-content/uploads/2018/11/VAST4.1-final-Nov-8-2018.pdf)

Created final structure and show in author's blog Ref : [VAST](http://daiji110.com/2020/07/19/vast/)

## Version
| Version  | Date  | Updates | 
|---|---|---|
| 0.1  | 2020/07/19  | First version  |