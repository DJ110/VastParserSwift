//
//  ParseState.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/9/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

open class ParseState {
    
    var vast : Vast = Vast()
    
    var errors : [ParseError] = []
    
    var lastElement : String = ""
    
    var parseElements : [String] = []
    
    // Helper Methods
    
    func updateParseElement(rank: Int, elementName: String) {
        
        if self.parseElements.count <= 1 {
            self.parseElements.append(elementName)
        } else {
            self.parseElements.insert(elementName, at: rank)
            self.parseElements = Array(self.parseElements[0...rank])
        }
    }
    
    func checkAnyParent(rank: Int, targetElementName: String) -> Bool {
        if rank < 0 {
            return false
        }
        if parseElements.count < rank {
            return false
        }
        let parent = parseElements[rank]
        return parent == targetElementName
    }
    
    func isInLine() -> Bool {
        return self.checkAnyParent(rank: 2, targetElementName: Constants.Element.INLINE)
    }
    
    func isWrapper() -> Bool {
        return self.checkAnyParent(rank: 2, targetElementName: Constants.Element.WRAPPER)
    }
}
