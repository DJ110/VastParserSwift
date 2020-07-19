//
//  Mezzanine.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Mezzaine {
    
    public var uri: String?    // media file CDTA-wrapped uri
    
    public var delivery: String?
    
    public var type: String?
    
    public var width: Int?
    
    public var height: Int?
    
    public var codec: String?   //RFC4281: http://tools.ietf.org/html/rfc4281.
    
    public var mezzaineId: String?        // id
    
    public var fileSize: Int?          // Bytes
    
    public var mediaType: String = "2D"        // 2D/3D/360 etc...
}
