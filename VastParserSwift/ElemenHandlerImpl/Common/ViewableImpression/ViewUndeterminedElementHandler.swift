//
//  ViewUndeterminedElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ViewUndeterminedElementHandler: ElementHandler {

    let rank: Int = 4
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: "ViewableImpression") {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.viewableImpression?.viewUndetermined.append(ViewUndetermined())
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.viewableImpression?.viewUndetermined.append(ViewUndetermined())
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "ViewUndetermined should be under InLine or Wrapper"))
            }
            
        } else {
            state.errors.append(ParseError(message: "ViewUndetermined should be under ViewableImpression"))
        }
    }
}
