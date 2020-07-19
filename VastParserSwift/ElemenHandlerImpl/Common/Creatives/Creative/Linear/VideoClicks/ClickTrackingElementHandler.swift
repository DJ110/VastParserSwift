//
//  ClickTrackingElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ClickTrackingElementHandler: ElementHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var clickTracking : ClickTracking = ClickTracking()
        if let clickTrackingId = attributeDict["id"] {
            clickTracking.clickTrackingId = clickTrackingId
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.VIDEOCLICKS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?
                    .videoClicks?.clickTracking.append(clickTracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?
                    .videoClicks?.clickTracking.append(clickTracking)
                state.updateParseElement(rank: rank, elementName: elementName)
            }
        } else {
            state.errors.append(ParseError(message: "ClickThrough should be under VideoClicks"))
        }
    }
}
