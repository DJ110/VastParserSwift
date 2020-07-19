//
//  VerificationParametersValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class VerificationParametersValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        
        if state.isInLine() {
            state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.verificationParameters?.uri = value
        } else if state.isWrapper() {
            state.vast.vastAd?.wrapper?.adVerifications?.verification.last?.verificationParameters?.uri = value
        }
    }
}
