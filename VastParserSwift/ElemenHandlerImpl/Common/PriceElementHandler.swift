//
//  PriceElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class PriceElementHandler : ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var pricing = Pricing()
        guard let model = attributeDict["model"] else {
            state.errors.append(ParseError(message: "model is required for Pricing"))
            return
        }
        guard let currency = attributeDict["currency"] else {
            state.errors.append(ParseError(message: "currency is required for Pricing"))
            return
        }
        if (!self.isIOS4217(value: currency)) {
            state.errors.append(ParseError(message: "Pricing currency is not correct format"))
            return
        }
        if (!self.isModel(value: model)) {
            state.errors.append(ParseError(message: "Model should be CPM, CPC, CPE, CPV"))
            return
        }
        
        pricing.model = model
        pricing.currency = currency
        
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.pricing = pricing
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.pricing = pricing
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "Pricing should be under Inline or Wrapper"))
        }
    }
    
    
    // Model Validator
    
    // Currency Validator IOS-4217
    private func isIOS4217(value: String) -> Bool {
        return value.count == 3
    }
    
    private func isModel(value: String) -> Bool {
        // CPM, CPC, CPE, or CPV
        let target = value.lowercased()
        switch(target) {
        case "cpm","cpc", "cpe", "cpv":
            return true
        default:
            return false
        }
    }
}
