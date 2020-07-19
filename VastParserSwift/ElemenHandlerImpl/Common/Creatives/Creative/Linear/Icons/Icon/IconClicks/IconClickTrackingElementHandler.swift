//
//  IconClickTrackingElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class IconClickTrackingElementHandler: ElementHandler {
    
    var rank: Int = 9
       
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var iconClickTracking = IconClickTracking()
        if let iconClickTrackingId = attributeDict["id"] {
            iconClickTracking.iconClickTrackingId = iconClickTrackingId
        }
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.ICONCLICKS) {
            
            if state.isInLine() {
            
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons?.icon.last?.iconClicks?.iconClickTracking.append(iconClickTracking)
                state.updateParseElement(rank: rank, elementName: elementName)
            
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.icons?.icon.last?.iconClicks?.iconClickTracking.append(iconClickTracking)
                state.updateParseElement(rank: rank, elementName: elementName)
            
            } else {
                state.errors.append(ParseError(message: "IconClickTracking should be under InLine or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "IconClickTracking should be under IconClicks"))
        }
    }
}
