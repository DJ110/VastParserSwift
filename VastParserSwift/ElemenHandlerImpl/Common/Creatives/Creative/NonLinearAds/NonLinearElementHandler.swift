//
//  NonLinearElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class NonLinearElementHandler: ElementHandler {
    
    let rank: Int = 6
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        var nonlinear: NonLinear = self.populateAttr(state: state, attributes: attributeDict)
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.NONLINEARADS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.append(nonlinear)
                state.updateParseElement(rank: rank, elementName: elementName)
            
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.nonlinarads?.nonlinear.append(nonlinear)
                state.updateParseElement(rank: rank, elementName: elementName)
            } else {
                state.errors.append(ParseError(message: "NonLinear should be under Creative of Inline or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "NonLinear should be under NonLinearAds"))
        }
    }
    
    func populateAttr(state: ParseState, attributes attributeDict: [String : String]) -> NonLinear {
        var nonlinear : NonLinear = NonLinear()
            
        if let nonlinearId = attributeDict["id"] {
            nonlinear.nonlinearId = nonlinearId
        }
        
        if let width = attributeDict["width"] {
            nonlinear.width = Int(width)
        }
        
        if let height = attributeDict["height"] {
            nonlinear.height = Int(height)
        }
        
        if let expandedWidth = attributeDict["expandedWidth"] {
            nonlinear.expandedWidth = Int(expandedWidth)
        }
        
        if let expandedHeight = attributeDict["expandedHeight"] {
            nonlinear.expandedHeight = Int(expandedHeight)
        }
        
        if let scalable = attributeDict["scalable"] {
            nonlinear.scalable = scalable.bool
        }
        
        if let maintainAspectRatio = attributeDict["maintainAspectRatio"] {
            nonlinear.maintainAspectRatio = maintainAspectRatio.bool
        }
        
        // apiFramework?
        if let apiFramework = attributeDict["apiFramework"] {
            nonlinear.apiFramework = apiFramework
        }
        
        if let minSuggestedDuration = attributeDict["minSuggestedDuration"] {
            if (self.checkFormat(value: minSuggestedDuration)) {
                nonlinear.minSuggestedDuration = minSuggestedDuration
            } else {
                state.errors.append(ParseError(message: "NonLinear minSuggestedDuration format should be HH:MM:SS or  HH:MM:SS.mmm"))
            }
        }
        
        return nonlinear
    }
    
    
    private func checkFormat(value: String) -> Bool {
        return value ~= "[0-9]{2}:[0-9]{2}:[0-9]{2}" || value ~= "[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9][0-9][0-9]{3}"
    }
}
