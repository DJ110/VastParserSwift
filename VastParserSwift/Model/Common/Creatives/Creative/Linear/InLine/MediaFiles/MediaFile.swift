//
//  MediaFile.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class MediaFile {
    
    public var uri: String?    // media file CDTA-wrapped uri
    
    public var delivery: String?
    
    public var type: String?
    
    public var width: Int?
    
    public var height: Int?
    
    public var codec: String?   //RFC4281: http://tools.ietf.org/html/rfc4281.
    
    public var mediafileId: String?        // id
    
    public var bitrate: Int?
    
    public var minBitrate: Int?
    
    public var maxBitrate: Int?
    
    public var scalable: Bool?
    
    public var maintainAspectRatio: Bool?
    
    public var apiFramework: String?  // Deprecated  <InteractiveCreativeFile>
    
    public var fileSize: Int?          // Bytes
    
    public var mediaType: String = "2D"        // 2D/3D/360 etc...
}
