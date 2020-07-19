//
//  AdVerificationTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/18/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift


class AdVerificationTest: XCTestCase {

    // Target : https://github.com/InteractiveAdvertisingBureau/VAST_Samples/blob/master/VAST%204.1%20Samples/Ad_Verification-test.xml
    // Thanks iAB

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdVerification() throws {
        
        let vastxml = """
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
                  <AdVerifications>
                    <Verification>
                      <JavaScriptResource>
                        <![CDATA[https://verificationcompany1.com/verification_script1.js]]>
                      </JavaScriptResource>
                    </Verification>
                    <Verification>
                      <JavaScriptResource>
                        <![CDATA[https://verificationcompany.com/untrusted.js]]>
                      </JavaScriptResource>
                    </Verification>
                  </AdVerifications>
                  <Advertiser>IAB Sample Company</Advertiser>
                  <Category authority="foo" />
                  <Creatives>
                    <Creative id="5480" sequence="1" adId="2447226">
                      <UniversalAdId idRegistry="Ad-ID" >8465</UniversalAdId>
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
        
        let vastParser = VastParser(contents: vastxml)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        // Ad
        XCTAssertEqual(false, vastParser.vast.vastAd?.conditionalAd)
        XCTAssertEqual(1, vastParser.vast.vastAd?.sequence)
        XCTAssertEqual("20001", vastParser.vast.vastAd?.adId)
        
        // AdVerifications
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.adVerifications)
        XCTAssertEqual(2, vastParser.vast.vastAd?.vastInline?.adVerifications?.verification.count)
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.adVerifications?.verification[0].javaScriptResource.count)
        XCTAssertEqual("https://verificationcompany1.com/verification_script1.js", vastParser.vast.vastAd?.vastInline?.adVerifications?.verification[0].javaScriptResource[0].uri)
        XCTAssertEqual("https://verificationcompany.com/untrusted.js", vastParser.vast.vastAd?.vastInline?.adVerifications?.verification[1].javaScriptResource[0].uri)
        
        // Check
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline)
        XCTAssertNil(vastParser.vast.vastAd?.wrapper)
        
    }
}
