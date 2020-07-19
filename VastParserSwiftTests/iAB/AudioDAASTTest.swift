//
//  AudioDAASTTest.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/18/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class AudioDAASTTest: XCTestCase {
    
    // Target : https://github.com/InteractiveAdvertisingBureau/VAST_Samples/blob/master/VAST%204.1%20Samples/Audio_DAAST_Sample.xml
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdVerification() throws {
        let vastxml = """
        <VAST version="4.1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.iab.com/VAST">
          <Ad id="20007" sequence="1" conditionalAd="false" adType="audio">
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
              <AdServingId>a532d16d-4d7f-4440-bd29-2ec0e693fc81</AdServingId>
              <AdTitle>iabtechlab audio ad</AdTitle>
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
                      <MediaFile id="5241" delivery="progressive" type="video/mp4" bitrate="2000" width="1280" height="720" minBitrate="1500" maxBitrate="2500" scalable="1" maintainAspectRatio="1" codec="FLAC">
                        <![CDATA[https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro.mp4]]>
                      </MediaFile>
                      <MediaFile id="5244" delivery="progressive" type="video/mp4" bitrate="1000" width="854" height="480" minBitrate="700" maxBitrate="1500" scalable="1" maintainAspectRatio="1" codec="FLAC">
                        <![CDATA[https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro-mid-resolution.mp4]]>
                      </MediaFile>
                      <MediaFile id="5246" delivery="progressive" type="video/mp4" bitrate="600" width="640" height="360" minBitrate="500" maxBitrate="700" scalable="1" maintainAspectRatio="1" codec="FLAC">
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
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline)
        XCTAssertEqual("audio", vastParser.vast.vastAd?.adType)
        
        // Ad System
        XCTAssertEqual("4.1", vastParser.vast.vastAd?.vastInline?.adSystem.version)
        XCTAssertEqual("iabtechlab", vastParser.vast.vastAd?.vastInline?.adSystem.value)
        
        // Impression
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.impression.count)
        XCTAssertEqual("Impression-ID", vastParser.vast.vastAd?.vastInline?.impression[0].impressionId)
        XCTAssertEqual("https://example.com/track/impression", vastParser.vast.vastAd?.vastInline?.impression[0].uri)
        
        // Pricing
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.pricing)
        XCTAssertEqual("cpm", vastParser.vast.vastAd?.vastInline?.pricing?.model)
        XCTAssertEqual("USD", vastParser.vast.vastAd?.vastInline?.pricing?.currency)
        XCTAssertEqual(25.0, vastParser.vast.vastAd?.vastInline?.pricing?.value)
        
        // AdServingId
        XCTAssertEqual("a532d16d-4d7f-4440-bd29-2ec0e693fc81", vastParser.vast.vastAd?.vastInline?.adServingId.value)
        
        // AdTitle
        XCTAssertEqual("iabtechlab audio ad", vastParser.vast.vastAd?.vastInline?.adTitle.value)
        
        // Creative
        XCTAssertEqual(1, vastParser.vast.vastAd?.vastInline?.creatives.creative.count)
        XCTAssertEqual("Ad-ID", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].universalAdid?.idRegistry)
        XCTAssertEqual("8465", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].universalAdid?.value)
        
        // Linear
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear)
        // Linear Tracking Event
        XCTAssertEqual(6, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent.count)
        XCTAssertEqual("start", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[0].event)
        XCTAssertEqual("progress", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[1].event)
        XCTAssertEqual("firstQuartile", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[2].event)
        XCTAssertEqual("midpoint", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[3].event)
        XCTAssertEqual("thirdQuartile", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[4].event)
        XCTAssertEqual("complete", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[5].event)
        
        XCTAssertEqual("https://example.com/tracking/start", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[0].uri)
        XCTAssertEqual("http://example.com/tracking/progress-10", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[1].uri)
        XCTAssertEqual("https://example.com/tracking/firstQuartile", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[2].uri)
        XCTAssertEqual("https://example.com/tracking/midpoint", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[3].uri)
        XCTAssertEqual("https://example.com/tracking/thirdQuartile", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[4].uri)
        XCTAssertEqual("https://example.com/tracking/complete", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.trackingEvents?.trackingEvent[5].uri)
        
        // Linear Duration
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.duration)
        XCTAssertEqual("00:00:16", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.duration?.value)
        
        // Linaer MediaFiles
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles)
        XCTAssertEqual(3, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile.count)
        XCTAssertEqual("5241", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].mediafileId)
        XCTAssertEqual("progressive", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].delivery)
        XCTAssertEqual("video/mp4", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].type)
        XCTAssertEqual(2000, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].bitrate)
        XCTAssertEqual(1280, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].width)
        XCTAssertEqual(720, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].height)
        XCTAssertEqual(1500, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].minBitrate)
        XCTAssertEqual(2500, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].maxBitrate)
        XCTAssertEqual(true, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].scalable)
        XCTAssertEqual(true, vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].maintainAspectRatio)
        XCTAssertEqual("FLAC", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].codec)
        XCTAssertEqual("https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro.mp4", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].uri)
        // Linear VideoClicks
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks)
        XCTAssertNotNil(vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks?.clickThrough)
        XCTAssertEqual("blog", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks?.clickThrough?.clickThroughId)
        XCTAssertEqual("https://iabtechlab.com", vastParser.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks?.clickThrough?.uri)
    }
}
