//
//  Verification.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Verification {
    
    public var vendor: String?  // required "company.com-omid TODO: Sampel does not have this parameter
    
    public var javaScriptResource: [JavaScriptResource] = [] // 0+
 
    public var executableResource: [ExecutableResource] = [] // 0+
    
    public var trackingEvents: TrackingEvents?         // 0-1
    
    public var verificationParameters: VerificationParameters? // 0-1
}
