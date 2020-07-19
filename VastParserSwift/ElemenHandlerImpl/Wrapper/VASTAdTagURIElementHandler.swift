//
//  VASTAdTagURIElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/15/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class VASTAdTagURIElementHandler: ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.vastAdTagURI = VASTAdTagURI()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "VASTAdTagURI should be under Wrapper element"))
        }
    }
}
