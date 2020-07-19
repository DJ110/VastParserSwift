//
//  Expires.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Expires {
    
    public var value: Int?   // expire period (s) second
    
    init(value: Int) {
        self.value = value
    }
}
