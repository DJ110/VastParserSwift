//
//  UniversalAdIdValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class UniversalAdIdValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        state.vast.vastAd?.vastInline?.creatives.creative.last?.universalAdid?.value = value
    }
}
