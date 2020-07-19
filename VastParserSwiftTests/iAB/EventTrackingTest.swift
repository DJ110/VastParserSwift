//
//  EventTrackingTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/19/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class EventTrackingTest: XCTestCase {
    
    var vastxml: String?

    override func setUpWithError() throws {
        self.vastxml = """
        <VAST version="4.1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.iab.com/VAST">
          <Ad id="20001" sequence="1" conditionalAd="false">
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
              <AdTitle>iabtechlab video ad</AdTitle>
              <Creatives>
                <Creative id="5480" sequence="1" adId="2447226">
                  <UniversalAdId idRegistry="Ad-ID">8465</UniversalAdId>
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
            </InLine>
          </Ad>
        </VAST>
        """
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEventTracking() throws {
        let vastParser = VastParser(contents: self.vastxml!)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear)
        XCTAssertEqual(6, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent.count)
        
        // Tracking Events
        XCTAssertEqual("start", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[0].event)
        XCTAssertEqual("progress", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[1].event)
        XCTAssertEqual("firstQuartile", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[2].event)
        XCTAssertEqual("midpoint", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[3].event)
        XCTAssertEqual("thirdQuartile", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[4].event)
        XCTAssertEqual("complete", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[5].event)
        
        XCTAssertEqual("https://example.com/tracking/start", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[0].uri)
        XCTAssertEqual("http://example.com/tracking/progress-10", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[1].uri)
        
    }
}