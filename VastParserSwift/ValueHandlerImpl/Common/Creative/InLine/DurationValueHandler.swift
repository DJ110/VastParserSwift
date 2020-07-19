//
//  DurationValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class DurationValueHandler: ValueHandler {
    
    func execute(state: ParseState, value: String) {
        // Format check
        //  HH:MM:SS or  HH:MM:SS.mmm
        if (self.checkFormat(value: value)) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.duration?.value = value
            
        } else {
            // Error
            state.errors.append(ParseError(message: "Duration format should be HH:MM:SS or  HH:MM:SS.mmm"))
        }
    }
    
    private func checkFormat(value: String) -> Bool {
        return value ~= "[0-9]{2}:[0-9]{2}:[0-9]{2}" || value ~= "[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9][0-9][0-9]{3}"
    }
}
