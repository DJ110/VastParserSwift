//
//  ClickThroughValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ClickThroughValueHandler: ValueHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, value: String) {
        
        if state.isInLine() {
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.videoClicks?.clickThrough?.uri = value
        }
    }
}
