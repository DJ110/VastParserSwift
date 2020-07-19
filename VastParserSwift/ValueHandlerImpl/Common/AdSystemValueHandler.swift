//
//  AdSystemValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class AdSystemValueHandler : ValueHandler {
    
    func execute(state: ParseState, value: String) {
        // inline? wrapper?
        if state.checkAnyParent(rank: 2, targetElementName: "InLine") {
            state.vast.vastAd?.vastInline?.adSystem.value = value
        } else if state.checkAnyParent(rank: 2, targetElementName: "Wrapper") {
            state.vast.vastAd?.wrapper?.adSystem.value = value
        }
    }
}
