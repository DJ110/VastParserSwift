//
//  ExtensionElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ExtensionElementHandler: ElementHandler {
    
    var rank: Int = 4
    
    // TODO: Extesion should be considered how to handle
    /*
     <Extensions>
     <Extension>
     <CustomXML>…</CustomXML>
     <Extension>
     </Extensions>
     */
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: "Extensions") {
            
            if state.checkAnyParent(rank: 2, targetElementName: "InLine") {
                state.parseExtension = true
            } else if state.checkAnyParent(rank: 2, targetElementName: "Wrapper") {
            
                state.updateParseElement(rank: rank, elementName: elementName)
                state.parseExtension = true
            } else {
                
            }
            
        } else {
            state.errors.append(ParseError(message: "Extension should be under InLine or Extensions"))
        }
    }
}
