//
//  ViewUndeterminedValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ViewUndeterminedValueHandler: ValueHandler {

    func execute(state: ParseState, value: String) {
        if state.isInLine() {
            state.vast.vastAd?.vastInline?.viewableImpression?.viewUndetermined.last?.uri = value
        } else if state.isWrapper() {
            state.vast.vastAd?.wrapper?.viewableImpression?.viewUndetermined.last?.uri = value
        }
    }
}
