//
//  ElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/9/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

protocol ElementHandler {
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String])
}
