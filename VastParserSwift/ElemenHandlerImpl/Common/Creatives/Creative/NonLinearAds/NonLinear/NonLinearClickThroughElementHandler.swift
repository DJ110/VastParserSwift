//
//  NonLinearClickThroughElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class NonLinearClickThroughElementHandler: ElementHandler {
    
    let rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.NONLINEAR)
            && state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.nonLinearClickThrough = NonLinearClickThrough()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "NonLinearClickThrough should be under NonLinear of InLine"))
        }
    }
    
}
