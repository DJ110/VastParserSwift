//
//  Constants.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Element {
        static let VAST = "VAST"
        
        static let ERROR = "Error"
        
        static let AD = "Ad"
        
        static let INLINE = "InLine"
        
        static let WRAPPER = "Wrapper"
        
        static let ADSYSTEM = "AdSystem"

        static let ADTITLE = "AdTitle"
        
        static let EXTENSION = "Extension"
        
        static let VASTADTAGURI = "VASTAdTagURI"
        
        static let ADVERIFICATIONS = "AdVerifications"
        
        static let BLOCKEDADCATEGORIES = "BlockedAdCategories"
        
        static let VERIFICATION = "Verification"
        
        static let LINEAR = "Linear"
        
        static let COMPANIONADS = "CompanionAds"
        
        static let COMPANION = "Companion"
        
        static let NONLINEAR = "NonLinear"
        
        static let NONLINEARADS = "NonLinearAds"
        
        static let TRACKINGEVENTS = "TrackingEvents"
        
        static let TRACKING = "Tracking"
        
        static let ADSERVINGID = "AdServingId"
        
        static let IMPRESSION = "Impression"
        
        static let PRICING = "Pricing"
        
        static let VIEWABLEIMPRESSION = "ViewableImpression"
        
        static let VIEWABLE = "Viewable"
        
        static let NOTVIEWABLE = "NotViewable"
        
        static let VIEWUNDETERMINED = "ViewUndetermined"
        
        static let CREATIVES = "Creatives"
        
        static let CREATIVE = "Creative"
        
        static let UNIVERSALADID = "UniversalAdId"
        
        static let CREATIVEEXTENSIONS = "CreativeExtensions"
        
        static let CREATIVEEXTENSION = "CreativeExtension"
        
        static let DURATION = "Duration"
        
        static let ADPAREMETERS = "AdParameters"
        
        static let CATEGORY = "Category"
        
        static let MEDIAFILES = "MediaFiles"
        
        static let MEDIAFILE = "MediaFile"
        
        static let MEZZANINE = "Mezzanine"
        
        static let INTERACTIVECREATIVEFILE = "InteractiveCreativeFile"
        
        static let CLOSEDCAPTIONFILES = "ClosedCaptionFiles"
        
        static let CLOSEDCAPTIONFILE = "ClosedCaptionFile"
        
        static let VIDEOCLICKS = "VideoClicks"
        
        static let CLICKTHROUGH = "ClickThrough"
        
        static let CLICKTRACKING = "ClickTracking"
        
        static let CUSTOMCLICK = "CustomClick"
        
        static let ICONS = "Icons"
        
        static let ICON = "Icon"
        
        static let ICONVIEWTRACKING = "IconViewTracking"
        
        static let ICONCLICKS = "IconClicks"
        
        static let ICONCLICKTHROUGH = "IconClickThrough"
        
        static let ICONCLICKTRACKING = "IconClickTracking"
        
        static let STATICRESOURCE = "StaticResource"
        
        static let IFRAMERESOURCE = "IFrameResource"
        
        static let HTMLRESOURCE = "HTMLResource"
        
        static let NONLINEARCLICKTHROUGH = "NonLinearClickThrough"
        
        static let NONLINEARCLICKTRACKING = "NonLinearClickTracking"
        
        static let ALTTEXT = "AltText"
        
        static let COMPANIONCLICKTHROUGH = "CompanionClickThrough"
        
        static let COMPANIONCLICKTRACKING = "CompanionClickTracking"
        
        static let JAVASCRIPTRESOURCE = "JavaScriptResource"
        
        static let EXECUTABLERESOURCE = "ExecutableResource"
        
        static let VERIFICATIONPARAMETERS = "VerificationParameters"
        
        static let EXTENSIONS = "Extensions"
        
        static let DESCRIPTION = "Description"
        
        static let ADVERTISER = "Advertiser"
        
        static let SURVEY = "Survey"
        
        static let EXPIRES = "Expires"
    }
    
    struct Attr {
        
    }
    
    public static let Targets : [String] = [
        Element.VAST,
        Element.ERROR,
        Element.AD,
        Element.INLINE,
        Element.WRAPPER,
        Element.ADSYSTEM,
        Element.ADTITLE,
        Element.EXTENSION,
        Element.VASTADTAGURI,
        Element.ADVERIFICATIONS,
        Element.BLOCKEDADCATEGORIES,
        Element.VERIFICATION,
        Element.LINEAR,
        Element.COMPANION,
        Element.NONLINEAR,
        Element.NONLINEARADS,
        Element.TRACKINGEVENTS,
        Element.ADSERVINGID,
        Element.IMPRESSION,
        Element.PRICING,
        Element.VIEWABLEIMPRESSION,
        Element.VIEWABLE,
        Element.NOTVIEWABLE,
        Element.VIEWUNDETERMINED,
        Element.CREATIVES,
        Element.CREATIVE,
        Element.UNIVERSALADID,
        Element.CREATIVEEXTENSIONS,
        Element.CREATIVEEXTENSION,
        Element.DURATION,
        Element.ADPAREMETERS,
        Element.CATEGORY,
        Element.MEDIAFILES,
        Element.MEDIAFILE,
        Element.MEZZANINE,
        Element.INTERACTIVECREATIVEFILE,
        Element.CLOSEDCAPTIONFILES,
        Element.CLOSEDCAPTIONFILE,
        Element.VIDEOCLICKS,
        Element.CLICKTHROUGH,
        Element.CLICKTRACKING,
        Element.CUSTOMCLICK,
        Element.ICONS,
        Element.ICON,
        Element.ICONVIEWTRACKING,
        Element.ICONCLICKS,
        Element.ICONCLICKTHROUGH,
        Element.ICONCLICKTRACKING,
        Element.STATICRESOURCE,
        Element.IFRAMERESOURCE,
        Element.HTMLRESOURCE,
        Element.NONLINEARCLICKTHROUGH,
        Element.NONLINEARCLICKTRACKING,
        Element.ALTTEXT,
        Element.COMPANIONCLICKTHROUGH,
        Element.COMPANIONCLICKTRACKING,
        Element.JAVASCRIPTRESOURCE,
        Element.EXECUTABLERESOURCE,
        Element.VERIFICATIONPARAMETERS,
        Element.DESCRIPTION,
        Element.ADVERTISER,
        Element.SURVEY,
        Element.EXPIRES
    ]
}
