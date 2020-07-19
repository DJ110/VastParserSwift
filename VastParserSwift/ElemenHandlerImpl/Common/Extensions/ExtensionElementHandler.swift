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
            
            if state.isInLine() {
                //state.parseExtension = true
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                //state.parseExtension = true
                state.updateParseElement(rank: rank, elementName: elementName)
            }
        } else {
            state.errors.append(ParseError(message: "Extension should be under InLine or Extensions"))
        }
    }
}
