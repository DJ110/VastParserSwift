//
//  NonLinearClickTrackingElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class NonLinearClickTrackingElementHandler: ElementHandler {
    
    let rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var nonLinearClickTracking : NonLinearClickTracking = NonLinearClickTracking()
        if let nonLinearClickTrackingId = attributeDict["id"] {
            nonLinearClickTracking.nonLinearClickTrackingId = nonLinearClickTrackingId
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.NONLINEAR) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.nonLinearClickTracking.append(nonLinearClickTracking)
                state.updateParseElement(rank: rank, elementName: elementName)
            
            } else if state.isWrapper() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.nonLinearClickTracking.append(nonLinearClickTracking)
                state.updateParseElement(rank: rank, elementName: elementName)
            }
        } else {
            state.errors.append(ParseError(message: "NonLinearClickTracking should be under NonLinear"))
        }
    }
}
