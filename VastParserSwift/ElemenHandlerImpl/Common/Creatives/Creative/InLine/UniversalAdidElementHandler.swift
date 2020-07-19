//
//  UniversalAdidElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class UniversalAdidElementHandler: ElementHandler {
    
    let rank: Int = 5
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var universalAdid = UniversalAdId()
        if let idRegistry = attributeDict["idRegistry"] {
            universalAdid.idRegistry = idRegistry
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.CREATIVE)
            && state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.universalAdid = universalAdid
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "UniversalAdId should be under Creative of Inline"))
        }
    }
}
