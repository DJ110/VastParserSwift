//
//  ClosedCaptionFileValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class ClosedCaptionFileValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.closedCaptionFiles?.closedCaptionFile.last?.uri = value
    }
}
