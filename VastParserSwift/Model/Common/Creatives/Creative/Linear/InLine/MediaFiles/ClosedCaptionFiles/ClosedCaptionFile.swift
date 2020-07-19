//
//  ClosedCaptionFile.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class ClosedCaptionFile {
    
    public var type: String?
    
    public var language: String?       //  ISO 631-1 codes Examples - “en”, “en-US”, “zh-TW”
    
    public var uri: String?  // A CDATA-wrapped URI 
}
