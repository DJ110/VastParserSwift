//
//  IconsElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class IconsElementHandler: ElementHandler {
    
    var rank: Int = 6
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.LINEAR) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons = Icons()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.icons = Icons()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "VideoClicks should be under Linear of InLine or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "Icons should be under Linear"))
        }
    }
}
