//
//  AdVerificationsElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation


class AdVerificationsElementHandler: ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.adVerifications = AdVerifications()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.adVerifications = AdVerifications()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "AdVerifications should be under InLine or Wrapper"))
        }
    }
}
