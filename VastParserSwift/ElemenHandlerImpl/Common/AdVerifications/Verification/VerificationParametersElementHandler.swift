//
//  VerificationParametersElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class VerificationParametersElementHandler: ElementHandler {
    
    let rank: Int = 5
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.VERIFICATION) {
            
            if state.isInLine() {
                state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.verificationParameters = VerificationParameters()
                state.updateParseElement(rank: rank, elementName: elementName)
            } else if state.isWrapper() {
                state.vast.vastAd?.wrapper?.adVerifications?.verification.last?.verificationParameters = VerificationParameters()
                state.updateParseElement(rank: rank, elementName: elementName)
            } else {
                state.errors.append(ParseError(message: "VerificationParameters should be under InLine or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "VerificationParameters should be under Verification"))
        }
    }
}
