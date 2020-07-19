//
//  CreativeExtensionElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CreativeExtensionElementHandler: ElementHandler {
    
    let rank: Int = 6
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var creativeExtension = CreativeExtension()
        if let type = attributeDict["type"] {
            creativeExtension.type = type
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.CREATIVEEXTENSIONS)
        && state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.creativeExtensions?.creativeExtension.append(creativeExtension)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "CreativeExtension should be under CreativeExtensions of Inline"))
        }
    }
}
