//
//  LinearElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class LinearElementHandler: ElementHandler {
    
    let rank: Int = 5
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var linear = Linear()
        if let skipoffset = attributeDict["skipoffset"] {
            linear.skipoffset = skipoffset
        }
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.CREATIVE) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear = linear
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear = linear
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Linear should be under Creative of Inline or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "Linear should be under Creative of Inline or Wrapper"))
        }
    }
}
