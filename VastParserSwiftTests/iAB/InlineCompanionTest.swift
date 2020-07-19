//
//  InlineCompanionTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/19/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class InlineCompanionTest: XCTestCase {

    var vastxml: String?
    
    override func setUpWithError() throws {
        self.vastxml = """
        <VAST version="4.1" xmlns="http://www.iab.com/VAST">
          <Ad id="20004" sequence="1" conditionalAd="false">
            <InLine>
              <AdSystem version="4.1">iabtechlab</AdSystem>
              <Error><![CDATA[https://example.com/error]]></Error>
              <Extensions>
                <Extension type="iab-Count">
                  <total_available>
                    <![CDATA[ 2 ]]>
                  </total_available>
                </Extension>
              </Extensions>
              <Impression id="Impression-ID"><![CDATA[https://example.com/track/impression]]></Impression>
              <Pricing model="cpm" currency="USD">
                <![CDATA[ 25.00 ]]>
              </Pricing>
              <AdServingId>a532d16d-4d7f-4440-bd29-2ec0e693fc80</AdServingId>
              <AdTitle>
                <![CDATA[VAST 4.0 Pilot - Scenario 5]]>
              </AdTitle>
              <Creatives>
                <Creative id="5480" sequence="1" adId="2447226">
                  <UniversalAdId idRegistry="Ad-ID" >8465</UniversalAdId>
                  <CompanionAds>
                    <Companion id="1232" width="100" height="150" assetWidth="250" assetHeight="200" expandedWidth="350" expandedHeight="250" adSlotId="3214" pxratio="1400">
                      <StaticResource creativeType="image/png">
                        <![CDATA[https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png]]>
                      </StaticResource>
                      <CompanionClickThrough>
                        <![CDATA[https://iabtechlab.com]]>
                      </CompanionClickThrough>
                    </Companion>
                  </CompanionAds>
                </Creative>
                <Creative id="5481" sequence="1" adId="2447226">
                  <UniversalAdId idRegistry="Ad-ID" >8466</UniversalAdId>
                  <Linear>
                    <TrackingEvents>
                      <Tracking event="start" ><![CDATA[https://example.com/tracking/start]]></Tracking>
                      <Tracking event="progress" offset="00:00:10"><![CDATA[http://example.com/tracking/progress-10]]></Tracking>
                      <Tracking event="firstQuartile"><![CDATA[https://example.com/tracking/firstQuartile]]></Tracking>
                      <Tracking event="midpoint"><![CDATA[https://example.com/tracking/midpoint]]></Tracking>
                      <Tracking event="thirdQuartile"><![CDATA[https://example.com/tracking/thirdQuartile]]></Tracking>
                      <Tracking event="complete"><![CDATA[https://example.com/tracking/complete]]></Tracking>
                    </TrackingEvents>
                    <Duration>00:00:16</Duration>
                    <MediaFiles>
                      <MediaFile id="5241" delivery="progressive" type="video/mp4" bitrate="2000" width="1280" height="720" minBitrate="1500" maxBitrate="2500" scalable="1" maintainAspectRatio="1" codec="H.264">
                        <![CDATA[https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro.mp4]]>
                      </MediaFile>
                      <MediaFile id="5244" delivery="progressive" type="video/mp4" bitrate="1000" width="854" height="480" minBitrate="700" maxBitrate="1500" scalable="1" maintainAspectRatio="1" codec="H.264">
                        <![CDATA[https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro-mid-resolution.mp4]]>
                      </MediaFile>
                      <MediaFile id="5246" delivery="progressive" type="video/mp4" bitrate="600" width="640" height="360" minBitrate="500" maxBitrate="700" scalable="1" maintainAspectRatio="1" codec="H.264">
                        <![CDATA[https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro-low-resolution.mp4]]>
                      </MediaFile>
                    </MediaFiles>
                    <VideoClicks>
                      <ClickThrough id="blog">
                        <![CDATA[https://iabtechlab.com]]>
                      </ClickThrough>
                    </VideoClicks>
                  </Linear>
                </Creative>
              </Creatives>
              <Description>
                <![CDATA[This is sample companion ad tag with Linear ad tag. This tag while showing video ad on the player, will show a companion ad beside the player where it can be fitted. At most 3 companion ads can be placed. Modify accordingly to see your own content. ]]>
              </Description>
            </InLine>
          </Ad>
        </VAST>
        """
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInlineCompanion() throws {
        let vastParser = VastParser(contents: self.vastxml!)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline)
        XCTAssertEqual(2, vastParser.vast.vastAd?.vastInline?.creatives.creative.count)
        
        // CompanionAds
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion.count)
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].staticResource.count)
        XCTAssertEqual("image/png", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].staticResource[0].creativeType)
        XCTAssertEqual("https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].staticResource[0].uri)
        XCTAssertEqual("https://iabtechlab.com", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].companionClickThrough?.uri)
    }
}
