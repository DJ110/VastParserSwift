//
//  ErrorValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ErrorValueHandler : ValueHandler {
    
    func execute(state: ParseState, value: String) {
        
        if (state.parseElements.count == 2) {
            // VAST Error
            state.vast.vastError?.url = value
            
        } else if state.isInLine() {
            // Inline Error
            state.vast.vastAd?.vastInline?.error.append(AdError(value: value))
            
        } else if state.isWrapper() {
            // Wrapper Error
            state.vast.vastAd?.wrapper?.error.append(AdError(value: value))
        }
    }
}
