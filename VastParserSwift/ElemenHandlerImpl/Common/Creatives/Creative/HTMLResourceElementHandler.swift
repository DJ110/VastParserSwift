//
//  HTMLResourceElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class HTMLResourceElementHandler: ElementHandler {
    
    // NonLinear, Companion, Icon :  InLine
    // Companion or Icon          :  Wrapper
    var rank: Int = 7 // 7: NonLinear, Companion 8: Icon
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        
        if (state.parseElements.contains(Constants.Element.ICON)) {
            self.rank = 8
        } else if (state.parseElements.contains(Constants.Element.COMPANION) || state.parseElements.contains(Constants.Element.NONLINEAR)) {
            self.rank = 7
        } else {
            // Erorr
            state.errors.append(ParseError(message: "HTMLResource should be under Icon or Companion, or NonLinear"))
            return
        }
        
        if self.rank == 8 {
            // Icon
            if state.checkAnyParent(rank: self.rank-1, targetElementName: Constants.Element.ICON) {
                if state.isInLine() {
                    
                    state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons?.icon.last?.htmlResource.append(HTMLResource())
                    state.updateParseElement(rank: rank, elementName: elementName)
                    
                } else if state.isWrapper() {
                    
                    state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.icons?.icon.last?.htmlResource.append(HTMLResource())
                    state.updateParseElement(rank: rank, elementName: elementName)
                    
                } else {
                    state.errors.append(ParseError(message: "HTMLResource should be under Icon of InLine or Wrapper"))
                }
            }
            
        } else if self.rank == 7 {
            if state.isInLine() {
                self.inlineHandler(state: state, elementName: elementName)
            } else if state.isWrapper() {
                self.wrapperHandler(state: state, elementName: elementName)
            } else {
                state.errors.append(ParseError(message: "HTMLResource should be under InLine or Wrapper"))
            }
        } else {
            state.errors.append(ParseError(message: "HTMLResource should be under Icon or NonLinear, Companion of InLine, Companion of Wrapper"))
        }
    }
    
    private func inlineHandler(state: ParseState, elementName: String) {
        if state.checkAnyParent(rank: self.rank-1, targetElementName: Constants.Element.NONLINEAR) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.htmlResource.append(HTMLResource())
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else if state.checkAnyParent(rank: self.rank-1, targetElementName: Constants.Element.COMPANION) {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.htmlResource.append(HTMLResource())
            state.updateParseElement(rank: rank, elementName: elementName)
        }
    }
    
    private func wrapperHandler(state: ParseState, elementName: String) {
        if state.checkAnyParent(rank: self.rank-1, targetElementName:Constants.Element.COMPANION) {
            state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.htmlResource.append(HTMLResource())
            state.updateParseElement(rank: rank, elementName: elementName)
        } else if state.checkAnyParent(rank: self.rank-1, targetElementName: Constants.Element.NONLINEAR) {
            state.errors.append(ParseError(message: "HTMLResource does not support NonLinear of Wrapper"))
        }
    }
}
