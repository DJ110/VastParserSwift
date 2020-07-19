//
//  ViewableImpressionHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ViewableImpressionElementHandler: ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var viewableImpression = ViewableImpression()
        if let viewableImpressionId = attributeDict["id"] {
            viewableImpression.viewableImpressionId = viewableImpressionId
        }
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.viewableImpression = viewableImpression
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.viewableImpression = viewableImpression
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "ViewableImpression should be under Inline or Wrapper"))
        }
        
    }
}
