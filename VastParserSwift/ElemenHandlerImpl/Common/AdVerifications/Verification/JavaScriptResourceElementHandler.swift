//
//  JavaScriptResourceElementHandler.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/12/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

class JavaScriptResourceElementHandler: ElementHandler {
    
    let rank: Int = 5
    
    /*
    <JavaScriptResource apiFramework="omid" browserOptional="true">
     <![CDATA[https://verificationvendor.com/omid.js]]>
    </JavaScriptResource>
    */
    
    func execute(state: ParseState, elementName: String, attributes attributeDict: [String : String]) {
  /*
        guard let apiFramework : String = attributeDict["apiFramework"] else {
            state.errors.append(ParseError(message: "JavaScriptResource should have apiFramework attr"))
            return
        }
            
        guard let browserOptional : String = attributeDict["browserOptional"] else {
            state.errors.append(ParseError(message: "JavaScriptResource should have browserOptional attr"))
            return
        }
   */
        var javaScriptResource : JavaScriptResource = JavaScriptResource()
        if let apiFramework = attributeDict["apiFramework"] {
            javaScriptResource.apiFramework = apiFramework
        }
        if let browserOptional = attributeDict["browserOptional"] {
             javaScriptResource.browserOptional = browserOptional.bool
        }
        
        if state.checkAnyParent(rank: rank-1, targetElementName: Constants.Element.VERIFICATION) {
            
            state.vast.vastAd?.vastInline?.adVerifications?.verification.last?.javaScriptResource.append(javaScriptResource)
            state.updateParseElement(rank: rank, elementName: elementName)
            
        } else {
            state.errors.append(ParseError(message: "JavaScriptResource should be under Verification"))
        }
    }
}
