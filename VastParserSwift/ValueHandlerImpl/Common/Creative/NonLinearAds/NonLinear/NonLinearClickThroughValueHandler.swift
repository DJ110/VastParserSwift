//
//  NonLinearClickThroughValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class NonLinearClickThroughValueHandler: ValueHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, value: String) {
        
        state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.nonLinearClickThrough?.uri = value
    }
}
