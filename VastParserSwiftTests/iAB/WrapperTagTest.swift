//
//  WrapperTagTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/19/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class WrapperTagTest: XCTestCase {

    // https://github.com/InteractiveAdvertisingBureau/VAST_Samples/blob/master/VAST%204.1%20Samples/Wrapper_Tag-test.xml
    var vastxml: String?
    
    override func setUpWithError() throws {
        self.vastxml = """
        <VAST version="4.1" xmlns="http://www.iab.com/VAST">
          <Ad id="20011" sequence="1" conditionalAd="false">
            <Wrapper followAdditionalWrappers="0" allowMultipleAds="1" fallbackOnNoAd="0">
              <AdSystem version="4.0">iabtechlab</AdSystem>
              <Error><![CDATA[https://example.com/error]]></Error>
              <Impression id="Impression-ID"><![CDATA[https://example.com/track/impression]]></Impression>
              <Creatives>
                <Creative id="5480" sequence="1" adId="2447226">
                  <CompanionAds>
                    <Companion id="1232" width="100" height="150" assetWidth="250" assetHeight="200" expandedWidth="350" expandedHeight="250" apiFramework="VPAID" adSlotId="3214" pxratio="1400">
                      <StaticResource creativeType="image/png">
                        <![CDATA[https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png]]>
                      </StaticResource>
                      <CompanionClickThrough>
                        <![CDATA[https://iabtechlab.com]]>
                      </CompanionClickThrough>
                    </Companion>
                  </CompanionAds>
                </Creative>
              </Creatives>
              <VASTAdTagURI>
                <![CDATA[https://raw.githubusercontent.com/InteractiveAdvertisingBureau/VAST_Samples/master/VAST%204.0%20Samples/Inline_Companion_Tag-test.xml]]>
              </VASTAdTagURI>
            </Wrapper>
          </Ad>
        </VAST>
        """
    }

    override func tearDownWithError() throws {
    }

    func testWrapperTag() throws {
        
        let vastParser = VastParser(contents: self.vastxml!)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        
        // Wrapper Tag
        XCTAssertNotNil(vastParser.vast.vastAd?.wrapper)
        
        // VASTAdTagURI
        XCTAssertEqual("https://raw.githubusercontent.com/InteractiveAdvertisingBureau/VAST_Samples/master/VAST%204.0%20Samples/Inline_Companion_Tag-test.xml", vastParser.vast.vastAd?.wrapper?.vastAdTagURI?.uri)
        
        XCTAssertNotNil(vastParser.vast.vastAd?.wrapper?.followAdditionalWrappers)
        XCTAssertEqual(false, vastParser.vast.vastAd?.wrapper?.followAdditionalWrappers)
        XCTAssertEqual(true, vastParser.vast.vastAd?.wrapper?.allowMultipleAds)
        XCTAssertEqual(false, vastParser.vast.vastAd?.wrapper?.fallbackOnNoAd)
        
        // AdSystem
        XCTAssertNotNil(vastParser.vast.vastAd?.wrapper?.adSystem)
        XCTAssertEqual("4.0", vastParser.vast.vastAd?.wrapper?.adSystem.version)
        XCTAssertEqual("iabtechlab", vastParser.vast.vastAd?.wrapper?.adSystem.value)
        
        // Error
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.error.count)
        XCTAssertEqual("https://example.com/error", vastParser.vast.vastAd?.wrapper?.error[0].value)
        
        // Impression
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.impression.count)
        XCTAssertEqual("Impression-ID", vastParser.vast.vastAd?.wrapper?.impression[0].impressionId)
        XCTAssertEqual("https://example.com/track/impression", vastParser.vast.vastAd?.wrapper?.impression[0].uri)
        
        // Creative
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.creatives?.creative.count)
        XCTAssertNotNil(vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds)
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion.count)
        
        // Companion
        /*
        <Companion id="1232" width="100" height="150" assetWidth="250" assetHeight="200" expandedWidth="350" expandedHeight="250" apiFramework="VPAID" adSlotId="3214" pxratio="1400">
          <StaticResource creativeType="image/png">
            <![CDATA[https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png]]>
          </StaticResource>
          <CompanionClickThrough>
            <![CDATA[https://iabtechlab.com]]>
          </CompanionClickThrough>
        </Companion>*/
        XCTAssertEqual("1232", vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].companionId)
        XCTAssertEqual(100, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].width)
        XCTAssertEqual(150, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].height)
        XCTAssertEqual(250, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].assetWidth)
        XCTAssertEqual(200, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].assetHeight)
        XCTAssertEqual(350, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].expandedWidth)
        XCTAssertEqual(250, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].expandedHeight)
        XCTAssertEqual("VPAID", vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].apiFramework)
        XCTAssertEqual("3214", vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].adSlotId)
        XCTAssertEqual(1400, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].pxratio)
        
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].staticResource.count)
        XCTAssertEqual("image/png", vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].staticResource[0].creativeType)
        
        XCTAssertEqual("https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png", vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].staticResource[0].uri)
        XCTAssertNotNil(vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].companionClickThrough)
        XCTAssertEqual("https://iabtechlab.com", vastParser.vast.vastAd?.wrapper?.creatives?.creative[0].companionAds?.companion[0].companionClickThrough?.uri)
    }
}
