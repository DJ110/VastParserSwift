//
//  CreativeElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CreativeElementHandler: ElementHandler {
    
    let rank: Int = 4
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var creative = Creative()
        if let creativeId = attributeDict["id"] {
            creative.creativeId = creativeId
        }
        if let adId = attributeDict["adId"] {
            creative.adId = adId
        }
        if let sequence = attributeDict["sequence"] {
            creative.sequence = Int(sequence)
        }
        if let apiFramework = attributeDict["apiFramework"] {
            creative.apiFramework = apiFramework
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.CREATIVES) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.append(creative)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.append(creative)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Creative should be under Inline or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "Creative should be under Creatives"))
        }
    }
}
