//
//  TrackingElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class TrackingElementHandler: ElementHandler {
    
    var rank: Int = 7 // 6: Verification, 7 : Linear, NonLinearAds, 8 : Companion
       
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        // Calcualte Rank
        
        if (state.parseElements.contains(Constants.Element.VERIFICATION)) {
            self.rank = 6
        } else if (state.parseElements.contains(Constants.Element.LINEAR) || state.parseElements.contains(Constants.Element.NONLINEARADS)) {
            self.rank = 7
        } else if state.parseElements.contains(Constants.Element.COMPANION) {
            self.rank = 8
        } else {
            // Erorr
            state.errors.append(ParseError(message: "Tracking should be under Lienar or Companion, or NonLinear"))
            return
        }
        
        // Create tracking element
        var tracking: Tracking = Tracking()
        if let event = attributeDict["event"] {
            tracking.event = event
        }
        if let offset = attributeDict["offset"] {
            tracking.offset = offset
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.TRACKINGEVENTS) {
            
           if state.checkAnyParent(rank: self.rank-2, targetElementName: Constants.Element.VERIFICATION) {
                if state.isInLine() {
                
                    state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.trackingEvents?.trackingEvent.append(tracking)
                    state.updateParseElement(rank: rank, elementName: elementName)
                
                } else if state.isWrapper() {
                
                    state.vast.vastAd?.wrapper?.adVerifications?.verification.last?.trackingEvents?.trackingEvent.append(tracking)
                    state.updateParseElement(rank: rank, elementName: elementName)
            
                } else {
                    state.errors.append(ParseError(message: "Tracking should be under InLine or Wrapper"))
                }
           } else if state.isInLine() {
            
                self.inlineHandler(state: state, elementName: elementName, tracking: tracking)
            
           } else if state.isWrapper() {
            
                self.wrapperHandler(state: state, elementName: elementName, tracking: tracking)
            
           } else {
                state.errors.append(ParseError(message: "Tracking should be under InLine or Wrapper"))
           }
        } else {
           state.errors.append(ParseError(message: "Tracking should be under TrackingEvents"))
        }
    }
    
    private func inlineHandler(state: ParseState, elementName: String, tracking: Tracking) {
        if self.rank == 7 {
            if state.checkAnyParent(rank: rank-2, targetElementName: Constants.Element.LINEAR) {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.trackingEvents?.trackingEvent.append(tracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.checkAnyParent(rank: rank-2, targetElementName: Constants.Element.NONLINEARADS) {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.trackingEvents?.trackingEvent.append(tracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Linear or NonLinearAds"))
            }
            
        } else if self.rank == 8 {
            if state.checkAnyParent(rank: rank-2, targetElementName: Constants.Element.COMPANION) {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.trackingEvents?.trackingEvent.append(tracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
                
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Companion"))
            }
        }
    }
    
    private func wrapperHandler(state: ParseState, elementName: String, tracking: Tracking) {
        if self.rank == 7 {
            if state.checkAnyParent(rank: rank-2, targetElementName: "Linear") {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.trackingEvents?.trackingEvent.append(tracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Linear"))
            }
            
        } else if self.rank == 8 {
            if state.checkAnyParent(rank: rank-2, targetElementName: "Companion") {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.trackingEvents?.trackingEvent.append(tracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.checkAnyParent(rank: rank-2, targetElementName: "NonLinear") {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.trackingEvents?.trackingEvent.append(tracking)
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "Tracking should be under Companion or NonLinear"))
            }
        }
    }
}
