//
//  ParseError.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/9/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public struct ParseError {
    
    let message : String
    
    init(message: String) {
        self.message = message
    }
    
    func showMessage() {
        
    }
}
