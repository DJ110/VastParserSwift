//
//  AdParametersElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdParametersElementHandler: ElementHandler {
    
    var rank: Int = 6  // Linear and InLine 6, Companion 7
    
    // Not sure of VPAID Object XML?
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var adParameters: AdParameters = AdParameters()
        if let xmlEncoded = attributeDict["xmlEncoded"] {
            adParameters.xmlEncoded = xmlEncoded
        }
        
        if state.checkAnyParent(rank: 5, targetElementName: Constants.Element.LINEAR)
            && state.isInLine() {
            
            self.rank = 6
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.adParameters = adParameters
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.checkAnyParent(rank: 6, targetElementName: Constants.Element.COMPANION) {
            self.rank = 7
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.adParameters = adParameters
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.adParameters = adParameters
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "AdParameters should be under Companion InLine or Companion"))
            }
            
        } else {
            state.errors.append(ParseError(message: "AdParameters should be under Linear InLine or Companion"))
        }
    }
}
