//
//  IconElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/11/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class IconElementHandler: ElementHandler {
    
    var rank: Int = 7
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.ICONS) {
            
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons?.icon.append(self.populateAttr(state: state, attributes: attributeDict))
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
            
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.icons?.icon.append(self.populateAttr(state: state, attributes: attributeDict))
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Icon should be under InLine or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "Icon should be under Icons"))
        }
    }
    
    func populateAttr(state: ParseState, attributes attributeDict: [String : String]) -> Icon {
        var icon : Icon = Icon()
        
        if let program = attributeDict["program"] {
            icon.program = program
        }
        if let width = attributeDict["width"] {
            icon.width = Int(width)
        }
        if let height = attributeDict["height"] {
            icon.height = Int(height)
        }
        if let xPosition = attributeDict["xPosition"] {
            icon.xPosition = xPosition
        }
        
        if let yPosition = attributeDict["yPosition"] {
            icon.yPosition = yPosition
        }
        // apiFramework?
        if let apiFramework = attributeDict["apiFramework"] {
            icon.apiFramework = apiFramework
        }
        if let duration = attributeDict["duration"] {
            if (self.checkFormat(value: duration)) {
                icon.duration = duration
            } else {
                state.errors.append(ParseError(message: "Icon duration format should be HH:MM:SS or  HH:MM:SS.mmm"))
            }
        }
        if let offset = attributeDict["offset"] {
            
            if (self.checkFormat(value: offset)) {
                icon.offset = offset
            } else {
                state.errors.append(ParseError(message: "Icon offset format should be HH:MM:SS or  HH:MM:SS.mmm"))
            }
        }
        return icon
    }
    
    private func checkFormat(value: String) -> Bool {
        return value ~= "[0-9]{2}:[0-9]{2}:[0-9]{2}" || value ~= "[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9][0-9][0-9]{3}"
    }
}
