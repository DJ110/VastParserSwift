//
//  JavaScriptResource.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class JavaScriptResource {
    
    var apiFramework: String?  // required
    
    var browserOptional: Bool? // required
    
    var uri: String?
    
    /*
     <JavaScriptResource apiFramework="omid" browserOptional="true">
      <![CDATA[https://verificationvendor.com/omid.js]]>
     </JavaScriptResource>
     */
}
