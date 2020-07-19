//
//  IconViewTrackingValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class IconViewTrackingValueHandler: ValueHandler {
    
    var rank: Int = 8
    
    func execute(state: ParseState, value: String) {
        
        if state.isInLine() {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons?.icon.last?.iconviewTracking.last?.uri = value
            
        } else if state.isWrapper() {
            
            state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.icons?.icon.last?.iconviewTracking.last?.uri = value
            
        }
    }
}
