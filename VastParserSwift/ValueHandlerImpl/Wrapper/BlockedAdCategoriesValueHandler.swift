//
//  BlockedAdCategoriesValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/15/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation


class BlockedAdCategoriesValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        state.vast.vastAd?.wrapper?.blockedAdCategories.last?.value = value
    }
}
