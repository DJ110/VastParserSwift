//
//  Ad.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Ad {
    
    public var adId : String = ""
    
    public var sequence : Int?
    
    public var conditionalAd : Bool?
    
    public var adType : String  = "video" // video, audio, hybrid
    
    public var vastInline : InLine?  // Inline or Wrapper
    
    public var wrapper : Wrapper?
}
