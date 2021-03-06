//
//  JavaScriptResourceValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class JavaScriptResourceValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.javaScriptResource.last?.uri = value
    }
}
