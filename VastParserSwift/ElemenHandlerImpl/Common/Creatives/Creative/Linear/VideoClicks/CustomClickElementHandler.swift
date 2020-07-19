//
//  CustomClickElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CustomClickElementHandler: ElementHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var customClick : CustomClick = CustomClick()
        if let customClickId = attributeDict["id"] {
            customClick.customClickId = customClickId
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.VIDEOCLICKS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?
                    .videoClicks?.customClick.append(customClick)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?
                .videoClicks?.customClick.append(customClick)
                state.updateParseElement(rank: rank, elementName: elementName)
            }
        } else {
            state.errors.append(ParseError(message: "CustomClick should be under VideoClicks"))
        }
    }
}
