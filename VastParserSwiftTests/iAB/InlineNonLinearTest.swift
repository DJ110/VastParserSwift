//
//  InlineNonLinearTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/19/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class InlineNonLinearTest: XCTestCase {
    
    var vastxml: String?

    override func setUpWithError() throws {
        self.vastxml = """
        <VAST version="4.1" xmlns="http://www.iab.com/VAST">
          <Ad id="20005" sequence="1" conditionalAd="false">
            <InLine>
              <AdSystem version="4.1">iabtechlab</AdSystem>
              <Error>
                <![CDATA[https://example.com/error]]>
              </Error>
              <Extensions>
                <Extension type="iab-Count">
                  <total_available>
                    <![CDATA[ 2 ]]>
                  </total_available>
                </Extension>
              </Extensions>
              <Impression id="Impression-ID">
                <![CDATA[https://example.com/track/impression]]>
              </Impression>
              <Pricing model="cpm" currency="USD">
                <![CDATA[ 25.00 ]]>
              </Pricing>
              <AdServingId>a532d16d-4d7f-4440-bd29-2ec0e693fc80</AdServingId>
              <AdTitle>
                <![CDATA[VAST 4.0 Pilot - Scenario 5]]>
              </AdTitle>
              <Creatives>
                <Creative id="5480" sequence="1" adId="2447226">
                  <UniversalAdId idRegistry="Ad-ID">8465</UniversalAdId>
                  <NonLinearAds>
                    <NonLinear width="350" height="350">
                      <StaticResource creativeType="image/png">
                        <![CDATA[https://mms.businesswire.com/media/20150623005446/en/473787/21/iab_tech_lab.jpg]]>
                      </StaticResource>
                      <NonLinearClickThrough>
                        <![CDATA[https://iabtechlab.com]]>
                      </NonLinearClickThrough>
                      <NonLinearClickTracking>
                        <![CDATA[https://example.com/tracking/clickTracking]]>
                      </NonLinearClickTracking>
                    </NonLinear>
                  </NonLinearAds>
                </Creative>
              </Creatives>
              <Description>
                <![CDATA[VAST 4.0 sample tag for Non Linear ad (i.e Overlay ad). Change the StaticResources to have a tag with your own content. Change NonLinear tag's parameters accordingly to view desired results.]]>
              </Description>
            </InLine>
          </Ad>
        </VAST>
        """
    }

    override func tearDownWithError() throws {
    }

    func testInlineLinearTest() throws {
        let vastParser = VastParser(contents: self.vastxml!)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        
        // Check NonLinear
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads)
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear.count)
        
        XCTAssertEqual(350, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].width)
        XCTAssertEqual(350, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].height)
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].staticResource.count)
        XCTAssertEqual("image/png", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].staticResource[0].creativeType)
        XCTAssertEqual("https://mms.businesswire.com/media/20150623005446/en/473787/21/iab_tech_lab.jpg", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].staticResource[0].uri)
        XCTAssertEqual("https://iabtechlab.com", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickThrough?.uri)
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickTracking.count)
        
        XCTAssertEqual("https://example.com/tracking/clickTracking", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickTracking[0].uri)
    }
}
