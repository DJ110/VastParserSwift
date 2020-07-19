//
//  VerificationElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class VerificationElementHandler: ElementHandler {
    
    let rank: Int = 4
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        // Document says required, but iab sampel does not have
        /*
        guard let vendor : String = attributeDict["vendor"] else {
            state.errors.append(ParseError(message: "Verification should have vendor attr"))
            return
        }*/
        var verification : Verification = Verification()
        
        if let vendor: String = attributeDict["vendor"] {
            verification.vendor = vendor
        }
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.ADVERIFICATIONS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.adVerifications?.verification.append(verification)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.adVerifications?.verification.append(verification)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Verification should be under InLine or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "Verification should be under AdVerifications"))
        }
    }
}
