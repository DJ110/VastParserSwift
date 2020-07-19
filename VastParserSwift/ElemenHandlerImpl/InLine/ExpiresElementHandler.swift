//
//  ExpiresElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ExpiresElementHandler: ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        if state.checkAnyParent(rank: rank-1, targetElementName: "InLine") {
            state.updateParseElement(rank: rank, elementName: elementName)
        } else {
            state.errors.append(ParseError(message: "Expires should be under Inline"))
        }
    }
}
