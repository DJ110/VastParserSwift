//
//  Wrapper.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Wrapper {
    
    public var followAdditionalWrappers: Bool?
    
    public var allowMultipleAds: Bool?
    
    public var fallbackOnNoAd: Bool?
    
    public var adSystem: AdSystem = AdSystem()
    
    public var error: [AdError] = []
    
    public var impression : [Impression] = []
    
    public var pricing: Pricing?            // 0-1
    
    public var viewableImpression: ViewableImpression?  // 0-1
    
    public var extensions: Extensions?              // 0-1
    
    public var creatives: Creatives?  // 0-1
    
    public var vastAdTagURI: VASTAdTagURI?      // 1
    
    public var adVerifications: AdVerifications?      // 0-1
    
    public var blockedAdCategories : [BlockedAdCategories] = [] // 0+
}
