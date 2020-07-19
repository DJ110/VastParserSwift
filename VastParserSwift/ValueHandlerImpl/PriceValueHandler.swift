//
//  PriceValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class PriceValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        if let price : Double = Double(value.trimmingCharacters(in: .whitespaces)) {
           state.vast.vastAd?.vastInline?.pricing?.value = price
        } else {
           state.errors.append(ParseError(message: "Pricing value should be numerical"))
        }
    }
}
