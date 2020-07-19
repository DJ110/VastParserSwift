//
//  InlineElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class InLineElementHandler : ElementHandler {
    
    let rank: Int = 2
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if (state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.AD)) {
            // InLine or Wrapper should have one only
            if (state.parseElements.count > rank) {
                state.errors.append(ParseError(message: "This VAST already contains Wrapper or InLine"))
            } else {
                state.vast.vastAd?.vastInline = InLine()
                state.updateParseElement(rank: rank, elementName: elementName)
            }
            
        } else {
            state.errors.append(ParseError(message: "Inline should be under Ad element"))
        }
    }
}
