//
//  NonLinear.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class NonLinear {
    
    public var nonlinearId: String?  // id
    
    public var width: Int?
    
    public var height: Int?
    
    public var expandedWidth: Int?
    
    public var expandedHeight: Int?
    
    public var scalable: Bool?
    
    public var maintainAspectRatio: Bool?
    
    public var apiFramework: String?
    
    public var minSuggestedDuration: String? //  HH:MM:SS.mmm   HH:MM:SS
    
    public var nonLinearClickThrough : NonLinearClickThrough?
    
    public var nonLinearClickTracking : [NonLinearClickTracking] = []
    
    public var trackingEvents : TrackingEvents?
    
    public var staticResource: [StaticResource] = []
    
    public var iframeResource: [IFrameResource] = []
    
    public var htmlResource: [HTMLResource] = []
}
