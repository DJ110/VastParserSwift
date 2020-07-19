//
//  ClosedCaptionFilesElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ClosedCaptionFilesElementHandler : ElementHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.MEDIAFILES) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.closedCaptionFiles = ClosedCaptionFiles()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "ClosedCaptionFiles should be under MediaFiles"))
        }
    }
}
