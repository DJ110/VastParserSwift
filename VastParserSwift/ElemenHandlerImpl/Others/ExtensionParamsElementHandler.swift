//
//  ExtensionParamsElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

// TODO

class ExtensionParamsElementHandler: ElementHandler {
    
    var rank: Int = 5
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: 4, targetElementName: "Extension") {
            
            // rank check
            self.rank = state.parseElements.count-1
            
            if state.checkAnyParent(rank: 2, targetElementName: "InLine") {
                
                
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.checkAnyParent(rank: 2, targetElementName: "Wrapper") {
            
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Extension should be under InLine or Extensions"))
            }
            
        } else {
            state.errors.append(ParseError(message: "Extension param should be under Extension"))
        }
    }
}
