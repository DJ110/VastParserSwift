//
//  SSAIStitchingMezzanineFileSupportTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/19/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class SSAIStitchingMezzanineFileSupportTest: XCTestCase {

    // https://github.com/InteractiveAdvertisingBureau/VAST_Samples/blob/master/VAST%204.1%20Samples/SSAI_stitching_mezzanine_file_support-test.xml
    var vastxml: String?
    
    override func setUpWithError() throws {
        self.vastxml = """
        <VAST version="4.1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.iab.com/VAST">
          <Ad id="20001" sequence="1" conditionalAd="false">
            <InLine>
              <AdSystem version="4.1">iabtechlab</AdSystem>
              <Error><![CDATA[https://example.com/error]]></Error>
              <Impression id="Impression-ID"><![CDATA[https://example.com/track/impression]]></Impression>
              <Pricing model="cpm" currency="USD">
                <![CDATA[ 25.00 ]]>
              </Pricing>
              <AdServingId>a532d16d-4d7f-4440-bd29-2ec0e693fc81</AdServingId>
              <AdTitle>iabtechlab video ad</AdTitle>
              <Creatives>
                <Creative id="5480" sequence="1" adId="2447226" apiFramework="VPAID">
                  <UniversalAdId idRegistry="Ad-ID">1234</UniversalAdId>
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
                      <Mezzanine delivery="streaming" width="1280" height="120" type="video/mp4">
                        <![CDATA[rtsp://pilot.iabtechlab.com/rawvideo?type=complete&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=4235]]>
                      </Mezzanine>
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
    }

    func testMezzanineFileSupport() throws {
        let vastParser = VastParser(contents: self.vastxml!)
        let success = vastParser.parse()
        
        XCTAssertTrue(success)
        
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles)
        XCTAssertEqual(3, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile.count)
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine.count)
        
        // Mezzanine
        XCTAssertEqual("streaming", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].delivery)
        XCTAssertEqual("video/mp4", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].type)
        XCTAssertEqual(1280, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].width)
        XCTAssertEqual(120, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].height)
        XCTAssertEqual("rtsp://pilot.iabtechlab.com/rawvideo?type=complete&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=4235", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].uri)
        
        // Media File
        XCTAssertEqual("progressive", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[2].delivery)
    }
}
