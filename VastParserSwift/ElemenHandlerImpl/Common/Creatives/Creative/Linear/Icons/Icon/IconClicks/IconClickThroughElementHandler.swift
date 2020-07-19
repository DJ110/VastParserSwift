//
//  IconClickThroughElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class IconClickThroughElementHandler: ElementHandler {
    
    var rank: Int = 9
       
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.ICONCLICKS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons?.icon.last?.iconClicks?.iconClickThrough = IconClickThrough()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.icons?.icon.last?.iconClicks?.iconClickThrough = IconClickThrough()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "IconClickThrough should be under InLine or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "IconClickThrough should be under IconClicks"))
        }
    }
}
