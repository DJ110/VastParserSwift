//
//  AdServingIdValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdServingIdValueHandler : ValueHandler {
    
    func execute(state: ParseState, value: String) {
        if state.parseElements.contains("InLine") {
            state.vast.vastAd?.vastInline?.adServingId.value = value
        }
    }
}
