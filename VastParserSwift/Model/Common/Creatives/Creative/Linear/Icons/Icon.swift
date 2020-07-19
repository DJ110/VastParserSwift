//
//  Icon.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Icon {
    
    public var program: String?
    
    public var width: Int?
    
    public var height: Int?
    
    public var xPosition: String?
    
    public var yPosition: String?
    
    public var duration: String?  //  HH:MM:SS.mmm  mmm is optional
    
    public var offset: String?  //  HH:MM:SS.mmm  mmm is optional
    
    public var apiFramework: String?
    
    public var pxratio: Int = 1
    
    public var iconviewTracking: [IconViewTracking] = []
    
    public var iconClicks: IconClicks?
    
    public var staticResource: [StaticResource] = []
    
    public var iframeResource: [IFrameResource] = []
    
    public var htmlResource: [HTMLResource] = []
}
