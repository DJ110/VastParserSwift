//
//  MediaFileElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class MediaFileElementHandler: ElementHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var mediaFile : MediaFile = self.populateAttr(attributes: attributeDict)
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.MEDIAFILES) {
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.mediafile.append(mediaFile)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "MediaFile should be under MediaFiles"))
        }
    }
    
    func populateAttr(attributes attributeDict: [String : String]) -> MediaFile {
        var mediaFile : MediaFile = MediaFile()
        if let delivery = attributeDict["delivery"] {
            mediaFile.delivery = delivery
        }
        if let type = attributeDict["type"] {
            mediaFile.type = type
        }
        if let width = attributeDict["width"] {
            mediaFile.width = Int(width)
        }
        if let height = attributeDict["height"] {
            mediaFile.height = Int(height)
        }
        if let codec = attributeDict["codec"] {
            mediaFile.codec = codec
        }
        if let mediafileId = attributeDict["id"] {
            mediaFile.mediafileId = mediafileId
        }
        if let bitrate = attributeDict["bitrate"] {
            mediaFile.bitrate = Int(bitrate)
        }
        if let minBitrate = attributeDict["minBitrate"] {
            mediaFile.minBitrate = Int(minBitrate)
        }
        if let maxBitrate = attributeDict["maxBitrate"] {
            mediaFile.maxBitrate = Int(maxBitrate)
        }
        if let scalable = attributeDict["scalable"] {
            mediaFile.scalable = scalable.bool
        }
        if let maintainAspectRatio = attributeDict["maintainAspectRatio"] {
            mediaFile.maintainAspectRatio = maintainAspectRatio.bool
        }
        // apiFramework?
        if let apiFramework = attributeDict["apiFramework"] {
            mediaFile.apiFramework = apiFramework
        }
        if let fileSize = attributeDict["fileSize"] {
            mediaFile.fileSize = Int(fileSize)
        }
        if let mediaType = attributeDict["mediaType"] {
            mediaFile.mediaType = mediaType
        }
        
        return mediaFile
    }
}
