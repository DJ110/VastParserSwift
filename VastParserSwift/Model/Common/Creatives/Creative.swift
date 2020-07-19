//
//  Creative.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Creative {
    
    public var creativeId: String?
    
    public var adId: String?
    
    public var sequence: Int?
    
    public var apiFramework: String?
    
    public var universalAdid: UniversalAdId?  // 1 : Inline, 0: Wrapper
    
    public var creativeExtensions: CreativeExtensions?  // 1: Inline, 0: Wrapper
    
    public var linear: Linear?
    
    public var nonlinarads: NonLinearAds?
    
    public var companionAds: CompanionAds?
}
