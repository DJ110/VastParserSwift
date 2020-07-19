//
//  MezzanineElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class MezzanineElementHandler : ElementHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var mezzanine : Mezzaine = self.populateAttr(attributes: attributeDict)
        
        if state.checkAnyParent(rank:rank-1, targetElementName: Constants.Element.MEDIAFILES) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.mezzanine.append(mezzanine)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "Mezzanine should be under MediaFiles"))
        }
    }
    
    func populateAttr(attributes attributeDict: [String : String]) -> Mezzaine {
        var mezzanine : Mezzaine = Mezzaine()
        if let delivery = attributeDict["delivery"] {
            mezzanine.delivery = delivery
        }
        if let type = attributeDict["type"] {
            mezzanine.type = type
        }
        if let width = attributeDict["width"] {
            mezzanine.width = Int(width)
        }
        if let height = attributeDict["height"] {
            mezzanine.height = Int(height)
        }
        if let codec = attributeDict["codec"] {
            mezzanine.codec = codec
        }
        if let mezzaineId = attributeDict["id"] {
            mezzanine.mezzaineId = mezzaineId
        }
        if let fileSize = attributeDict["fileSize"] {
            mezzanine.fileSize = Int(fileSize)
        }
        if let mediaType = attributeDict["mediaType"] {
            mezzanine.mediaType = mediaType
        }
        
        return mezzanine
    }
}
