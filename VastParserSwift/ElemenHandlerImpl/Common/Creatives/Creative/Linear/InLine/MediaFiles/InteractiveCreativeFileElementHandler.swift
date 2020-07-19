//
//  InteractiveCreativeFileElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class InteractiveCreativeFileElementHandler: ElementHandler {
    
    var rank: Int = 7  // MediaFiles : 7 or  Linear : 6
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var interactiveCreativeFile : InteractiveCreativeFile = InteractiveCreativeFile()
        if let type = attributeDict["type"] {
            interactiveCreativeFile.type = type
        }
        if let apiFramework = attributeDict["apiFramework"] {
            interactiveCreativeFile.apiFramework = apiFramework
        }
        if let variableDuration = attributeDict["variableDuration"] {
            interactiveCreativeFile.variableDuration = variableDuration.bool
        }
        
        // Mediafiles are reuiqred
        if state.checkAnyParent(rank: 6, targetElementName: Constants.Element.MEDIAFILES) {
            self.rank = 7
            state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.mediaFiles?.interactiveCreativeFile.append(interactiveCreativeFile)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.checkAnyParent(rank: 5, targetElementName: Constants.Element.LINEAR)
        && state.isWrapper() {
            
            self.rank = 6
            state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.interactiveCreativeFile.append(interactiveCreativeFile)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "InteractiveCreativeFile should be under MediaFiles or Linear"))
        }
    }
}
