//
//  BlockedAdCategoriesElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/15/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class BlockedAdCategoriesElementHandler: ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        guard let authority : String = attributeDict["authority"] else {
            state.errors.append(ParseError(message: "BlockedAdCategories should have authority attr"))
            return
        }
        var blockedAdCategories = BlockedAdCategories()
        blockedAdCategories.authority = authority
        
        if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.blockedAdCategories.append(blockedAdCategories)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "BlockedAdCategories should be under Wrapper element"))
        }
        
    }
}
