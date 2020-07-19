//
//  SurveyElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class SurveyElementHandler: ElementHandler {
 
    let rank: Int = 3
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
        var survey = Survey()
        if let type = attributeDict["type"] {
            survey.type = type
        }
        if state.isInLine() {
            state.vast.vastAd?.vastInline?.survey.append(survey)
            state.updateParseElement(rank: rank, elementName: elementName)
        } else {
            state.errors.append(ParseError(message: "Survey should be under Inline"))
        }
    }
}
