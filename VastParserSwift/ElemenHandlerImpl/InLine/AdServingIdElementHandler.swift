//
//  AdServingIdElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdServingIdElementHandler : ElementHandler {
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        if !state.parseElements.contains("InLine") {
            // Error
            state.errors.append(ParseError(message: "AdServingId should be under Inline"))
        }
    }
}
