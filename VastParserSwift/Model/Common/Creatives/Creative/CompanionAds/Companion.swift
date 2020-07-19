//
//  Companion.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Companion {
    
    public var companionId: String?
    
    public var width: Int?
    
    public var height: Int?
    
    public var assetWidth: Int?
    
    public var assetHeight: Int?
    
    public var expandedWidth: Int?
    
    public var expandedHeight: Int?
    
    public var apiFramework: String?
    
    public var adSlotId: String?
    
    public var pxratio: Int? = 1
    
    public var renderingMode: String? = "default" // “default” or “end-card” or “concurrent”.
    
    public var altText: AltText?
    
    public var companionClickThrough: CompanionClickThrough?
    
    public var companionClickTracking: [CompanionClickTracking] = []
    
    public var trackingEvents : TrackingEvents?
    
    public var staticResource: [StaticResource] = []
    
    public var iframeResource: [IFrameResource] = []
    
    public var htmlResource: [HTMLResource] = []
    
    public var adParameters: AdParameters?
}
