//
//  ClosedCaptionFileElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ClosedCaptionFileElementHandler : ElementHandler {
    
    var rank: Int = 8
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var closedCaptionFile : ClosedCaptionFile = ClosedCaptionFile()
        if let type = attributeDict["type"] {
            closedCaptionFile.type = type
        }
        if let language = attributeDict["language"] {
            closedCaptionFile.language = language
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.CLOSEDCAPTIONFILES) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.closedCaptionFiles?.closedCaptionFile.append(closedCaptionFile)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "ClosedCaptionFile should be under ClosedCaptionFiles"))
        }
    }
}
