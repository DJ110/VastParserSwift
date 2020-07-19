//
//  Linear.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class Linear {
    
    public var skipoffset: String?
    
    public var duration: Duration?  //  HH:MM:SS.mmm
    
    public var adParameters: AdParameters?
    
    public var mediaFiles: MediaFiles?
    
    public var videoClicks: VideoClicks?
    
    public var icons: Icons?
    
    public var trackingEvents : TrackingEvents?
    
    public var interactiveCreativeFile: [InteractiveCreativeFile] = []
}
