//
//  TrackingEventsElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class TrackingEventsElementHandler: ElementHandler {
    
    var rank: Int = 6 // 5: Verification, 6 : Linear, NonLinearAds, 7 : Companion
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        // Calcualte Rank
        if (state.parseElements.contains(Constants.Element.VERIFICATION)) {
           self.rank = 5
        } else if (state.parseElements.contains(Constants.Element.LINEAR) || state.parseElements.contains(Constants.Element.NONLINEARADS)) {
            self.rank = 6
        } else if state.parseElements.contains(Constants.Element.COMPANION) {
            self.rank = 7
        } else {
            // Erorr
            state.errors.append(ParseError(message: "TrackingEvents should be under Lienar or Companion, or NonLinear"))
            return
        }
        
        if state.checkAnyParent(rank: self.rank-1, targetElementName: Constants.Element.VERIFICATION) {
            // Verification
            if state.isInLine() {
                
                state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.isWrapper() {
                
                state.vast.vastAd?.wrapper?.adVerifications?.verification.last?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "TrackingEvents should be under InLine or Wrapper"))
            }
            
        } else if state.isInLine() {
            
            self.inlineHandler(state: state, elementName: elementName)
            
        } else if state.isWrapper() {
            
            self.wrapperHandler(state: state, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "TrackingEvents should be under InLine or Wrapper"))
        }
        
    }
    
    private func inlineHandler(state: ParseState, elementName: String) {
        if self.rank == 6 {
            if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.LINEAR) {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.linear?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.NONLINEARADS) {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.nonlinarads?.nonlinear.last?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "TrackingEvents should be under Linear or NonLinearAds"))
            }
            
        } else if self.rank == 7 {
            if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.COMPANION) {
                
                state.vast.vastAd?.vastInline?.creatives.creative.last?.companionAds?.companion.last?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "TrackingEvents should be under Companion"))
            }
        }
    }
    
    private func wrapperHandler(state: ParseState, elementName: String) {
        if self.rank == 6 {
            if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.LINEAR) {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.linear?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.NONLINEARADS) {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.nonlinarads?.nonlinear.last?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "TrackingEvents should be under Linear  or NonLinearAds"))
            }
            
        } else if self.rank == 7 {
            if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.COMPANION) {
                
                state.vast.vastAd?.wrapper?.creatives?.creative.last?.companionAds?.companion.last?.trackingEvents = TrackingEvents()
                state.updateParseElement(rank: rank, elementName: elementName)
                
            } else {
                state.errors.append(ParseError(message: "TrackingEvents should be under Companion or NonLinear"))
            }
        }
    }
}
