//
//  ImpressionElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ImpressionElementHandler : ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var impression = Impression()
        if let impid = attributeDict["id"] {
            impression.impressionId = impid
        }
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.impression.append(impression)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.impression.append(impression)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "Impression should be under Inline or Wrapper"))
        }
    }
}
