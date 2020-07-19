//
//  CompanionClickTrackingValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CompanionClickTrackingValueHandler: ValueHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, value: String) {
       
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.companionClickTracking.last?.uri = value
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.companionClickTracking.last?.uri = value
            
        } else {
            state.errors.append(ParseError(message: "CompanionClickTracking sould be under Inline or Wrapper"))
        }
    }
}
