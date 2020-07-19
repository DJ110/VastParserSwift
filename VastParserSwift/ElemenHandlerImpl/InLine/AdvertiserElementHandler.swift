//
//  AdvertiserElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdvertiserElementHandler : ElementHandler {
    
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var advertiser = Advertiser()
        if let advertiserId = attributeDict["id"] {
            advertiser.advertiserId = advertiserId
        }
        if state.isInLine() {
            state.vast.vastAd?.vastInline?.advertiser = advertiser
            state.updateParseElement(rank: rank, elementName: elementName)
        } else {
            state.errors.append(ParseError(message: "Advertiser should be under Inline"))
        }
    }
}
