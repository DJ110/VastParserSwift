//
//  CategoryElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CategoryElementHandler : ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var category = Category()
        if let authority = attributeDict["authority"] {
            category.authority = authority
        }
        
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.category.append(category)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "Category should be under Inline"))
        }
    }
}
