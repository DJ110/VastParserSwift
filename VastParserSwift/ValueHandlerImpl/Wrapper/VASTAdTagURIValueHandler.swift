//
//  VASTAdTagURIValueElement.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/15/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class VASTAdTagURIValueHandler : ValueHandler {
    
    func execute(state: ParseState, value: String) {
        state.vast.vastAd?.wrapper?.vastAdTagURI?.uri = value
    }
}
