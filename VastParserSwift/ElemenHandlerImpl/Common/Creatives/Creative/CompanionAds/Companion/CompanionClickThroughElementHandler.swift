//
//  CompanionClickThroughElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CompanionClickThroughElementHandler: ElementHandler {
 
    let rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.COMPANION) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.companionClickThrough = CompanionClickThrough()
                state.updateParseElement(rank: rank, elementName: elementName)
            
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.companionClickThrough = CompanionClickThrough()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "CompanionClickThrough should be under Creative of Inline or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "CompanionClickThrough should be under Companion"))
        }
    }
}
