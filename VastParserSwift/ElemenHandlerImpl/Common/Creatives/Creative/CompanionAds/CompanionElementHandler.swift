//
//  CompanionElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class CompanionElementHandler: ElementHandler {
    
    let rank: Int = 6
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var companion: Companion = self.populateAttr(state: state, attributes: attributeDict)
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.COMPANIONADS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.append(companion)
                state.updateParseElement(rank: rank, elementName: elementName)
            
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.append(companion)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Companion should be under Creative of Inline or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "Companion should be under CompanionAds"))
        }
    }
    
    func populateAttr(state: ParseState, attributes attributeDict: [String : String]) -> Companion {
        var companion : Companion = Companion()
            
        if let companionId = attributeDict["id"] {
            companion.companionId = companionId
        }
        
        if let width = attributeDict["width"] {
            companion.width = Int(width)
        }
        
        if let assetWidth = attributeDict["assetWidth"] {
            companion.assetWidth = Int(assetWidth)
        }
        
        if let assetHeight = attributeDict["assetHeight"] {
            companion.assetHeight = Int(assetHeight)
        }
        
        if let height = attributeDict["height"] {
            companion.height = Int(height)
        }
        
        
        if let expandedWidth = attributeDict["expandedWidth"] {
            companion.expandedWidth = Int(expandedWidth)
        }
        
        if let expandedHeight = attributeDict["expandedHeight"] {
            companion.expandedHeight = Int(expandedHeight)
        }
        
        if let adSlotId = attributeDict["adSlotId"] {
            companion.adSlotId = adSlotId
        }
        
        if let pxratio = attributeDict["pxratio"] {
            companion.pxratio = Int(pxratio)
        }
        
        // apiFramework?
        if let apiFramework = attributeDict["apiFramework"] {
            companion.apiFramework = apiFramework
        }
        
        if let renderingMode = attributeDict["renderingMode"] {
            companion.renderingMode = renderingMode
        }
        return companion
    }
}
