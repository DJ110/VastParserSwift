//
//  ExpiresValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ExpiresValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        if let expire : Int = Int(value.trimmingCharacters(in: .whitespaces)) {
            state.vast.vastAd?.vastInline?.expires = Expires(value: expire)
        } else {
           state.errors.append(ParseError(message: "Expires value should be numerical"))
        }
    }
}
