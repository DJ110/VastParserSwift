//
//  NonViewableValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation


class NotViewableValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        if state.isInLine() {
            state.vast.vastAd?.vastInline?.viewableImpression?.notViewable.last?.uri = value
        } else if state.isWrapper() {
            state.vast.vastAd?.wrapper?.viewableImpression?.notViewable.last?.uri = value
        }
    }
}
