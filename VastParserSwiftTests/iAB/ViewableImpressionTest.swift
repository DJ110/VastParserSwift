//
//  ViewableImpressionTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/19/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class ViewableImpressionTest: XCTestCase {

    // https://github.com/InteractiveAdvertisingBureau/VAST_Samples/blob/master/VAST%204.1%20Samples/Viewable_Impression-test.xml
    var vastxml: String?
    
    override func setUpWithError() throws {
        self.vastxml = """
        <VAST version="4.1" xmlns="http://www.iab.com/VAST">
          <Ad id="20010" sequence="1" conditionalAd="false">
            <Wrapper followAdditionalWrappers="0" allowMultipleAds="1" fallbackOnNoAd="0">
              <AdSystem version="4.0">iabtechlab</AdSystem>
              <Error><![CDATA[https://example.com/error]]></Error>
              <Impression id="Impression-ID"><![CDATA[https://example.com/track/impression]]></Impression>
              <ViewableImpression id="1543">
                <Viewable>
                  <![CDATA[https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243]]>
                </Viewable>
                <NotViewable>
                  <![CDATA[https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243]]>
                </NotViewable>
                <ViewUndetermined>
                  <![CDATA[https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243]]>
                </ViewUndetermined>
              </ViewableImpression>
              <Creatives>
                <Creative id="5480" sequence="1" adId="2447226">
                  <Linear>
                    <TrackingEvents>
                      <Tracking event="start"><![CDATA[http://example.com/tracking/start]]></Tracking>
                      <Tracking event="progress" offset="00:00:10"><![CDATA[http://example.com/tracking/progress-10]]></Tracking>
                    </TrackingEvents>
                  </Linear>
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

    func testViewableImpression() throws {
        let vastParser = VastParser(contents: self.vastxml!)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        XCTAssertNotNil(vastParser.vast.vastAd?.wrapper?.viewableImpression)
        
        XCTAssertEqual("1543", vastParser.vast.vastAd?.wrapper?.viewableImpression?.viewableImpressionId)
        
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.viewableImpression?.viewable.count)
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.viewableImpression?.notViewable.count)
        XCTAssertEqual(1, vastParser.vast.vastAd?.wrapper?.viewableImpression?.viewUndetermined.count)
        
        XCTAssertEqual("https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243", vastParser.vast.vastAd?.wrapper?.viewableImpression?.viewable[0].uri)
        
        XCTAssertEqual("https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243", vastParser.vast.vastAd?.wrapper?.viewableImpression?.notViewable[0].uri)
        
        XCTAssertEqual("https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243", vastParser.vast.vastAd?.wrapper?.viewableImpression?.viewUndetermined[0].uri)
    }
}
