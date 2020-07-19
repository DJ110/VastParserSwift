//
//  ExtensionsElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ExtensionsElementHandler: ElementHandler {
    
    var rank: Int = 3
    
    // TODO: Extesion should be considered how to handle
    /*
     <Extensions>
     <Extension>
     <CustomXML>…</CustomXML>
     <Extension>
     </Extensions>
     */
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: "InLine") {
            
            state.vast.vastAd?.vastInline?.extensions = Extensions()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.checkAnyParent(rank: rank-1, targetElementName: "Wrapper") {
             
            state.vast.vastAd?.wrapper?.extensions = Extensions()
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "Extensions should be under InLine or Wrapper"))
        }
    }
}
