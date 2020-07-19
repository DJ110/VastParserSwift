//
//  AdElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdElementHandler : ElementHandler {
    
    let rank : Int = 1
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if (state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.VAST)) {
            var ad = Ad()
            if let adId = attributeDict["id"] {
                ad.adId = adId
            }
            if let sequence = attributeDict["sequence"] {
                ad.sequence = Int(sequence)
            }
            if let conditionalAd = attributeDict["conditionalAd"] {
                ad.conditionalAd = Bool(conditionalAd)
            }
            if let adType = attributeDict["adType"] {
                ad.adType = adType
            }
            state.vast.vastAd = ad
            state.updateParseElement(rank: rank, elementName: elementName)
        } else {
            state.errors.append(ParseError(message: "Ad should be under VAST element"))
        }
    }
}
