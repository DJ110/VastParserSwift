//
//  InteractiveCreativeFileValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class InteractiveCreativeFileValueHandler: ValueHandler {
    
    var rank: Int = 7  // MediaFiles : 7 or  Linear : 6
    
    func execute(state: ParseState, value: String) {
        // TODO Not only inline
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.MEDIAFILES) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.interactiveCreativeFile.last?.uri = value
        
        } else if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.LINEAR)
        && state.isWrapper() {
        
            state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.interactiveCreativeFile.last?.uri = value
        }
        
    }
}

