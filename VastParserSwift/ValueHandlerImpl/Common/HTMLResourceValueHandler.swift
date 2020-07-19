//
//  HTMLResourceValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class HTMLResourceValueHandler: ValueHandler {
    
    // Icon(InLine), NonLinear, Companion
    var rank: Int = 7 // 7: NonLinear, Companion 8: Icon
    
    func execute(state: ParseState, value: String) {
        
        if (state.parseElements.contains("Icon")) {
            self.rank = 8
        } else if (state.parseElements.contains("Companion") || state.parseElements.contains("NonLinear")) {
            self.rank = 7
        } else {
            // Erorr
            state.errors.append(ParseError(message: "HTMLResource should be under Icon or Companion, or NonLinear"))
            return
        }
        
        if self.rank == 8 {
            // Icon
            if state.checkAnyParent(rank: self.rank-1, targetElementName: "Icon") {
                
                // InLine Only
                if state.checkAnyParent(rank: 2, targetElementName: "InLine") {
                    
                    state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.icons?.icon.last?.htmlResource.last?.uri = value
                    
                } else {
                    state.errors.append(ParseError(message: "HTMLResource should be under Icon of InLine"))
                }
                
            } else {
                state.errors.append(ParseError(message: "HTMLResource should be under Icon"))
            }
            
        } else if self.rank == 7 {
            // Companion or NonLinear
            if state.checkAnyParent(rank: 2, targetElementName: "InLine") {
                self.inlineHandler(state: state, value: value)
            } else if state.checkAnyParent(rank: 2, targetElementName: "Wrapper") {
                self.wrapperHandler(state: state, value: value)
            } else {
                state.errors.append(ParseError(message: "HTMLResource should be under InLine or Wrapper"))
            }
        }
    }
    
    private func inlineHandler(state: ParseState, value: String) {
        if state.checkAnyParent(rank: self.rank-1, targetElementName: "NonLinear") {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.htmlResource.last?.uri = value
            
        } else if state.checkAnyParent(rank: self.rank-1, targetElementName: "Companion") {
            
            state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.htmlResource.last?.uri = value
        
        }
    }
    
    private func wrapperHandler(state: ParseState, value: String) {
        if state.checkAnyParent(rank: self.rank-1, targetElementName: "Companion") {
        
            state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.htmlResource.last?.uri = value
        
        } else if state.checkAnyParent(rank: self.rank-1, targetElementName: "NonLinear") {
            state.errors.append(ParseError(message: "HTMLResource does not support NonLinear of Wrapper"))
        }
    }
}
