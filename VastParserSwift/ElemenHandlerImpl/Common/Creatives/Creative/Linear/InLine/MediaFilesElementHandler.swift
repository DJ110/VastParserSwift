//
//  MediaFiles.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class MediaFilesElementHandler: ElementHandler {
    
    var rank: Int = 6
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.LINEAR)
        && state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles = MediaFiles()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "MediaFiles should be under Linear of Inline"))
        }
    }
}
