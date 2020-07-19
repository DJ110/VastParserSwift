//
//  VASTElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/9/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class VASTElementHandler : ElementHandler {
    
    private let rank = 0
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var vast = Vast()
        if let version = attributeDict["version"] {
            vast.version = version
            
            if version != "4.1" {
                state.errors.append(ParseError(message: "Not Support version \(version)"))
            }
        }
        state.vast = vast
        state.updateParseElement(rank: rank, elementName: elementName)
    }
}
