//
//  CreativeElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CreativesElementHandler: ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives = Creatives()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.creatives = Creatives()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "Creatives should be under Inline or Wrapper"))
        }
    }
}
