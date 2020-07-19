//
//  ErrorElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ErrorElementHandler : ElementHandler {
    
    private var rank = 1 // 1 or 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if (state.parseElements.count < 2) {
            if (state.checkAnyParent(rank: 0, targetElementName: Constants.Element.VAST)) {
                
                // VAST ERROR
                state.vast.vastError = VastError()
                state.updateParseElement(rank: 1, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Error should be under VAST"))
            }
        } else if (state.parseElements.count > 3) {
            if (state.isInLine() ||
                state.isWrapper()) {
                    
                state.updateParseElement(rank: 3, elementName: elementName)
                    
            } else {
                state.errors.append(ParseError(message: "Error should be under InLine or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "Error should be under some elements"))
        }
    }
}
