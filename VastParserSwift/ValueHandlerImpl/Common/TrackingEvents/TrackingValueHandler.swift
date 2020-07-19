//
//  TrackingValueHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class TrackingValueHandler: ValueHandler {
    
    var rank: Int = 7 // 6: Verification, 7 : Linear, 8 : Companion, NonLinear
    
    func execute(state: ParseState, value: String) {
        
        // Calcualte Rank
        
        if (state.parseElements.contains("Verification")) {
            self.rank = 6
        } else if (state.parseElements.contains("Linear")) {
            self.rank = 7
        } else if (state.parseElements.contains("Companion") || state.parseElements.contains("NonLinear")) {
            self.rank = 8
        } else {
            // Erorr
            state.errors.append(ParseError(message: "Tracking should be under Lienar or Companion, or NonLinear"))
            return
        }
            
        if state.checkAnyParent(rank: self.rank-2, targetElementName: "Verification") {
            state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.trackingEvents?.trackingEvent.last?.uri = value
        } else if state.checkAnyParent(rank: 2, targetElementName: "InLine") {
            self.inlineHandler(state: state, value: value)
        } else if state.checkAnyParent(rank: 2, targetElementName: "Wrapper") {
            self.wrapperHandler(state: state, value: value)
        } else {
            state.errors.append(ParseError(message: "Tracking should be under Verification or InLine or Wrapper"))
        }
    }
        
    private func inlineHandler(state: ParseState, value: String) {
        if self.rank == 7 {
            if state.checkAnyParent(rank: rank-2, targetElementName: "Linear") {
                    
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.trackingEvents?.trackingEvent.last?.uri = value
                    
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Linear"))
            }
                
        } else if self.rank == 8 {
            if state.checkAnyParent(rank: rank-2, targetElementName: "Companion") {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.trackingEvents?.trackingEvent.last?.uri = value
                    
            } else if state.checkAnyParent(rank: rank-2, targetElementName: "NonLinear") {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.trackingEvents?.trackingEvent.last?.uri = value
    
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Companion or NonLinear"))
            }
        }
    }
    
    private func wrapperHandler(state: ParseState, value: String) {
        if self.rank == 7 {
            if state.checkAnyParent(rank: rank-2, targetElementName: "Linear") {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.trackingEvents?.trackingEvent.last?.uri = value
                
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Linear"))
            }
            
        } else if self.rank == 8 {
            if state.checkAnyParent(rank: rank-2, targetElementName: "Companion") {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.trackingEvents?.trackingEvent.last?.uri = value
                
            } else if state.checkAnyParent(rank: rank-2, targetElementName: "NonLinear") {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.nonlinarads?.nonlinear.last?.trackingEvents?.trackingEvent.last?.uri = value
                
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Companion or NonLinear"))
            }
        }
    }
}
