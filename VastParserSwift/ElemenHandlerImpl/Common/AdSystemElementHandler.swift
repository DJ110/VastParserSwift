//
//  AdSystemElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdSystemElementHandler : ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var adSystem = AdSystem()
        if let version = attributeDict["version"] {
            adSystem.version = version
        }
        
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.adSystem = adSystem
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.WRAPPER) {
            
            state.vast.vastAd?.wrapper?.adSystem = adSystem
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "AdSystem should be under Inline or Wrapper element"))
        }
    }
}
