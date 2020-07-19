//
//  AdParametersValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/18/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation


public class AdParametersValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        
        if state.checkAnyParent(rank: 5, targetElementName: Constants.Element.LINEAR)
            && state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.adParameters?.value = value
            
        } else if state.checkAnyParent(rank: 6, targetElementName: Constants.Element.COMPANION) {
            if state.isInLine() {
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.adParameters?.value = value
            } else if state.isWrapper() {
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.adParameters?.value = value
            }
        }
    }
}
