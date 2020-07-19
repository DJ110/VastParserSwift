//
//  ViewableImpression.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/10/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

public class ViewableImpression {
    
    var viewableImpressionId: String?
    
    var viewable : [Viewable] = []  // 0+
    
    var notViewable : [NotViewable] = []  // 0+
    
    var viewUndetermined : [ViewUndetermined] = [] // 0+
}
