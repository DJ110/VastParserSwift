//
//  Inline.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class InLine {
    
    public var adSystem : AdSystem = AdSystem()
    
    public var adTitle : AdTitle = AdTitle()
    
    public var impression : [Impression] = []       // 1+
    
    public var adServingId : AdServingId = AdServingId()
    
    public var category : [Category] = []           // 0+
    
    public var description : Description?   // 0-1
    
    public var advertiser : Advertiser?     // 0-1
    
    public var pricing: Pricing?            // 0-1
    
    public var survey: [Survey] = []        // 0+
    
    public var error: [AdError] = []
    
    public var expires: Expires?  // 0-1
    
    public var viewableImpression: ViewableImpression?  // 0-1
    
    public var adVerifications: AdVerifications?      // 0-1
    
    public var extensions: Extensions?              // 0-1
    
    public var creatives: Creatives = Creatives()   // 1
}
