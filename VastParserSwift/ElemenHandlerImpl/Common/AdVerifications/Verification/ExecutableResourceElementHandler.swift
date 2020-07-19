//
//  ExecutableResourceElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ExecutableResourceElementHandler: ElementHandler {
    
    let rank: Int = 5
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        guard let apiFramework : String = attributeDict["apiFramework"] else {
            state.errors.append(ParseError(message: "ExecutableResource should have apiFramework attr"))
            return
        }
            
        guard let type : String = attributeDict["type"] else {
            state.errors.append(ParseError(message: "ExecutableResource should have type attr"))
            return
        }
        
        var executableResource : ExecutableResource = ExecutableResource()
        executableResource.apiFramework = apiFramework
        executableResource.type = type
        
        if state.checkAnyParent(rank: rank-1, targetElementName: "Verification") {
            
            state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.executableResource.append(executableResource)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "JavaScriptResource should be under Verification"))
        }
    }
}
