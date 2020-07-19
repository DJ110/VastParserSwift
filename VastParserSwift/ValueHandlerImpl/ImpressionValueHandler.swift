//
//  ImpressionValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ImpressionValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        // inline? wrapper?
        if state.parseElements.contains("InLine") {
            state.vast.vastAd?.vastInline?.impression.last?.uri = value
        } else if state.parseElements.contains("Wrapper") {
            state.vast.vastAd?.wrapper?.impression.last?.uri = value
        }
    }
}
