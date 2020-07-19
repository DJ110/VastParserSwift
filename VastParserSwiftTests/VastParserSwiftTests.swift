//
//  VastParserSwiftTests.swift
//  VastParserSwiftTests
//
//  Created by 伊藤大司 on 7/9/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import XCTest
@testable import VastParserSwift

class VastParserSwiftTests: XCTestCase {
    
    // Check : https://github.com/InteractiveAdvertisingBureau/VAST_Samples/tree/master/VAST%204.1%20Samples

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
/*
    func testExample() throws {
        let errorVast = """
        <VAST version="4.1">
            <Error>
                <![CDATA[http://adserver.com/noad.gif]]>
            </Error>
        </VAST>
        """
        let vastParser = VastParser(contents: errorVast)
        vastParser.parse()
        XCTAssertEqual("4.1", vastParser.state.vast.version)
        XCTAssertEqual("http://adserver.com/noad.gif", vastParser.state.vast.vastError?.url)
    }
    
    func testAd() throws {
        let adVast = """
        <VAST version="4.1" xmlns="http://www.iab.com/VAST">
            <Ad id="20004" sequence="1" conditionalAd="false">
            </Ad>
        </VAST>
        """
        let vastParser = VastParser(contents: adVast)
        vastParser.parse()
        
        XCTAssertEqual(false, vastParser.state.vast.vastAd?.conditionalAd)
        XCTAssertEqual("20004", vastParser.state.vast.vastAd?.id)
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.sequence)
    }
 
    func testAdInline() throws {
        let adVast = """
        <VAST version="4.1" xmlns="http://www.iab.com/VAST">
            <Ad id="20004" sequence="1" conditionalAd="false">
                <InLine>
                    <AdSystem version="4.1">iabtechlab</AdSystem>
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
                    <Pricing model="cpm" currency="USD">
                      <![CDATA[ 25.00 ]]>
                    </Pricing>
                    <AdServingId>a532d16d-4d7f-4440-bd29-2ec0e693fc80</AdServingId>
                    <AdTitle>
                      <![CDATA[VAST 4.0 Pilot - Scenario 5]]>
                    </AdTitle>
                    <Advertiser id="Advertiser-ID">IAB Sample Company</Advertiser>
                    <Category authority="https://www.iabtechlab.com/categoryauthority">American Cuisine</Category>
                    <Category authority="https://www.iabtechlab.com/categoryauthority1">Guitar</Category>
                    <Category authority="https://www.iabtechlab.com/categoryauthority">Vegan</Category>
                    <Description>
                      <![CDATA[This is sample companion ad tag with Linear ad tag. This tag while showing video ad on the player, will show a companion ad beside the player where it can be fitted. At most 3 companion ads can be placed. Modify accordingly to see your own content. ]]>
                    </Description>
                    <Survey type="text/html">
                        <![CDATA[https://example.com/track/survey]]>
                    </Survey>
                    <Expires>60</Expires>
                    <Creatives>
                        <Creative id="5480" sequence="1" adId="2447226">
                            <UniversalAdId idRegistry="Ad-ID">8465</UniversalAdId>
                            <CreativeExtensions>
                                <CreativeExtension type="text/html">
                                </CreativeExtension>
                            </CreativeExtensions>
                            <Linear skipoffset="00:00:05">
                                <TrackingEvents>
                                    <Tracking event="start" ><![CDATA[https://example.com/tracking/start]]></Tracking>
                                    <Tracking event="progress" offset="00:00:10"><![CDATA[http://example.com/tracking/progress-10]]></Tracking>
                                    <Tracking event="firstQuartile"><![CDATA[https://example.com/tracking/firstQuartile]]></Tracking>
                                    <Tracking event="midpoint"><![CDATA[https://example.com/tracking/midpoint]]></Tracking>
                                    <Tracking event="thirdQuartile"><![CDATA[https://example.com/tracking/thirdQuartile]]></Tracking>
                                    <Tracking event="complete"><![CDATA[https://example.com/tracking/complete]]></Tracking>
                                </TrackingEvents>
                                <Duration>00:00:16</Duration>
                                <AdParameters xmlEncoded="xxxxx">
                                </AdParameters>
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
                                    <InteractiveCreativeFile type="video/mp4" variableDuration="1">
                                      <![CDATA[https://pilot.iabtechlab.com/beacon?type=complete&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=4235]]>
                                    </InteractiveCreativeFile>
                                    <ClosedCaptionFiles>
                                        <ClosedCaptionFile type="text/srt" language="en">
                                            <![CDATA[https://mycdn.example.com/creatives/creative001.srt]]>
                                        </ClosedCaptionFile>
                                        <ClosedCaptionFile type="text/srt" language="fr">
                                            <![CDATA[https://mycdn.example.com/creatives/creative001-1.srt]]>
                                        </ClosedCaptionFile>
                                        <ClosedCaptionFile type="text/vtt" language="zh-TW">
                                            <![CDATA[https://mycdn.example.com/creatives/creative001.vtt]]>
                                        </ClosedCaptionFile>
                                        <ClosedCaptionFile type="application/ttml+xml" language="zh-CH">
                                            <![CDATA[https://mycdn.example.com/creatives/creative001.ttml]]>
                                        </ClosedCaptionFile>
                                    </ClosedCaptionFiles>
                                </MediaFiles>
                                <VideoClicks>
                                  <ClickThrough id="blog">
                                    <![CDATA[https://iabtechlab.com]]>
                                  </ClickThrough>
                                  <ClickTracking id="blog">
                                    <![CDATA[https://iabtechlab.com]]>
                                   </ClickTracking>
                                </VideoClicks>
                                <Icons>
                                  <Icon program="AdChoices" width="50" height="50" xPosition="left" yPosition="top">
                                    <IconViewTracking>
                                      <![CDATA[https://youradchoices.com/DAA_style/YAC/Icon_White_Box.png]]>
                                    </IconViewTracking>
                                    <IconViewTracking>
                                      <![CDATA[https://youradchoices.com/DAA_style/YAC/Icon_Black_Box.png]]>
                                    </IconViewTracking>
                                    <IconClicks>
                                        <IconClickThrough>
                                            <![CDATA[https://youradchoices.com/DAA_style/YAC/Icon_Black_Box.png]]>
                                        </IconClickThrough>
                                        <IconClickTracking id="yyyyy">
                                            <![CDATA[https://youradchoices.com/DAA_style/YAC/Icon_Blue_Box.png]]>
                                        </IconClickTracking>
                                    </IconClicks>
                                  </Icon>
                                </Icons>
                            </Linear>
                        </Creative>
                    </Creatives>
                </InLine>
            </Ad>
        </VAST>
        """
        let vastParser = VastParser(contents: adVast)
        vastParser.parse()
        
        XCTAssertNotNil(vastParser.state.vast.vastAd)
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline)
        XCTAssertEqual("4.1", vastParser.state.vast.vastAd?.vastInline?.adSystem.version)
        XCTAssertEqual("iabtechlab", vastParser.state.vast.vastAd?.vastInline?.adSystem.value)
        XCTAssertEqual("https://example.com/error", vastParser.state.vast.vastAd?.vastInline?.error[0].value)
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.adTitle)
        XCTAssertEqual("VAST 4.0 Pilot - Scenario 5", vastParser.state.vast.vastAd?.vastInline?.adTitle.value)
        XCTAssertEqual("a532d16d-4d7f-4440-bd29-2ec0e693fc80", vastParser.state.vast.vastAd?.vastInline?.adServingId.value)
        
        // Impression
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.impression.count)
        XCTAssertEqual("Impression-ID", vastParser.state.vast.vastAd?.vastInline?.impression[0].impressionId)
        XCTAssertEqual("https://example.com/track/impression", vastParser.state.vast.vastAd?.vastInline?.impression[0].uri)
        
        // Category
        XCTAssertEqual(3, vastParser.state.vast.vastAd?.vastInline?.category.count)
        XCTAssertEqual("https://www.iabtechlab.com/categoryauthority", vastParser.state.vast.vastAd?.vastInline?.category[0].authority)
        XCTAssertEqual("https://www.iabtechlab.com/categoryauthority1", vastParser.state.vast.vastAd?.vastInline?.category[1].authority)
        XCTAssertEqual("Vegan", vastParser.state.vast.vastAd?.vastInline?.category[2].value)
        
        // Description
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.description)
        XCTAssertEqual("This is sample companion ad tag with Linear ad tag. This tag while showing video ad on the player, will show a companion ad beside the player where it can be fitted. At most 3 companion ads can be placed. Modify accordingly to see your own content. ", vastParser.state.vast.vastAd?.vastInline?.description?.value)
        
        // Advertiser
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.advertiser)
        XCTAssertEqual("Advertiser-ID", vastParser.state.vast.vastAd?.vastInline?.advertiser?.advertiserId)
        XCTAssertEqual("IAB Sample Company", vastParser.state.vast.vastAd?.vastInline?.advertiser?.value)
        
        // Pricing
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.pricing)
        XCTAssertEqual("cpm", vastParser.state.vast.vastAd?.vastInline?.pricing?.model)
        XCTAssertEqual("USD", vastParser.state.vast.vastAd?.vastInline?.pricing?.currency)
        XCTAssertEqual(25.0, vastParser.state.vast.vastAd?.vastInline?.pricing?.value)
        
        // Survey
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.survey.count)
        XCTAssertEqual("text/html", vastParser.state.vast.vastAd?.vastInline?.survey[0].type)
        XCTAssertEqual("https://example.com/track/survey", vastParser.state.vast.vastAd?.vastInline?.survey[0].uri)
        
        // Expires
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.expires)
        XCTAssertEqual(60, vastParser.state.vast.vastAd?.vastInline?.expires?.value)
        
        // Viewable Impression
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.viewableImpression)
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.viewableImpression?.viewable.count)
        XCTAssertEqual("https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243", vastParser.state.vast.vastAd?.vastInline?.viewableImpression?.viewable[0].uri)
        // NotViewable
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.viewableImpression?.notViewable.count)
        XCTAssertEqual("https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243", vastParser.state.vast.vastAd?.vastInline?.viewableImpression?.notViewable[0].uri)
        
        // ViewUndertermined
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.viewableImpression?.viewUndetermined.count)
        XCTAssertEqual("https://search.iabtechlab.com/error?errcode=102&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=1243", vastParser.state.vast.vastAd?.vastInline?.viewableImpression?.viewUndetermined[0].uri)
        
        // Creatives
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives)
        
        // Creative
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative.count)
        XCTAssertEqual("5480", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].creativeId)
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].sequence)
        XCTAssertEqual("2447226", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].adId)
        
        
        // UniversalAdid
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].universalAdid)
        XCTAssertEqual("Ad-ID", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].universalAdid?.idRegistry)
        XCTAssertEqual("8465", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].universalAdid?.value)
        
        // CreativeExtensions
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].creativeExtensions)
        // CreativeExtension
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].creativeExtensions?.creativeExtension[0])
        
        // Linear
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear)
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.skipoffset)
        
        XCTAssertEqual("00:00:05", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.skipoffset)
        
        // Duration
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.duration)
        
        XCTAssertEqual("00:00:16", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.duration?.value)
        
        // AdParameters
        XCTAssertEqual("xxxxx", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.adParameters?.xmlEncoded)
        
        // MediaFiles
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles)
        
        // Media File
        XCTAssertEqual(3, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile.count)
        
        XCTAssertEqual("5241", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].mediafileId)
        
        XCTAssertEqual("progressive", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].delivery)
        
        XCTAssertEqual("video/mp4", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].type)
        
        XCTAssertEqual(2000, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].bitrate)
        
        XCTAssertEqual(1280, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].width)
        
        XCTAssertEqual(720, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].height)
        
        XCTAssertEqual(1500, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].minBitrate)
        
        XCTAssertEqual(2500, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].maxBitrate)
        
        XCTAssertEqual(true, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].scalable)
        
        XCTAssertEqual(true, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].maintainAspectRatio)
        
        XCTAssertEqual("H.264", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].codec)
        
        XCTAssertEqual("https://iab-publicfiles.s3.amazonaws.com/vast/VAST-4.0-Short-Intro.mp4", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mediafile[0].uri)
        
        // Mezzanine
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine.count)
        
        XCTAssertEqual("streaming", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].delivery)
        
        XCTAssertEqual(1280, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].width)
        
        XCTAssertEqual(120, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].height)
        
        XCTAssertEqual("video/mp4", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].type)
        
         XCTAssertEqual("rtsp://pilot.iabtechlab.com/rawvideo?type=complete&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=4235", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.mezzanine[0].uri)
        
        // InteractiveCreativeFile
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.interactiveCreativeFile)
        XCTAssertEqual("video/mp4", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.interactiveCreativeFile[0].type)
        
        XCTAssertEqual(true, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.interactiveCreativeFile[0].variableDuration)
        
        XCTAssertEqual("https://pilot.iabtechlab.com/beacon?type=complete&imprid=s5-ea2f7f298e28c0c98374491aec3dfeb1&ts=4235", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.interactiveCreativeFile[0].uri)
        
        // ClosedCaptionFiles and ClosedCaptionFile
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.closedCaptionFiles)
        
        XCTAssertEqual(4, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.closedCaptionFiles?.closedCaptionFile.count)
        
        XCTAssertEqual("https://mycdn.example.com/creatives/creative001.srt", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.closedCaptionFiles?.closedCaptionFile[0].uri)
        
        XCTAssertEqual("text/srt", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.closedCaptionFiles?.closedCaptionFile[0].type)
        
        XCTAssertEqual("en", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.mediaFiles?.closedCaptionFiles?.closedCaptionFile[0].language)
        
        // VideoClicks, ClickThrough, ClickTracking, CustomClick
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks)
        
        XCTAssertEqual("blog", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks?.clickThrough?.clickThroughId)
        
        XCTAssertEqual("https://iabtechlab.com", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.videoClicks?.clickThrough?.uri)
        
        // Icons, Icon
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons)
        
        XCTAssertEqual("AdChoices", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].program)
        
        XCTAssertEqual(50, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].width)
        
        XCTAssertEqual(50, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].height)
        
        XCTAssertEqual("left", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].xPosition)
        
        XCTAssertEqual("top", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].yPosition)
        
        // IconViewTracking
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].iconviewTracking)
        
        XCTAssertEqual(2, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].iconviewTracking.count)
        
        XCTAssertEqual("https://youradchoices.com/DAA_style/YAC/Icon_White_Box.png", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon[0].iconviewTracking[0].uri)
        
        // IconClicks, IconClickThrough, IconClickTracking
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks)
        
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks?.iconClickThrough)
        
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks?.iconClickThrough)
        
        XCTAssertEqual("https://youradchoices.com/DAA_style/YAC/Icon_Black_Box.png", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks?.iconClickThrough?.uri)
        
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks?.iconClickTracking.count)
        
        XCTAssertEqual("https://youradchoices.com/DAA_style/YAC/Icon_Blue_Box.png", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks?.iconClickTracking[0].uri)
        
        XCTAssertEqual("yyyyy", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].linear?.icons?.icon.last?.iconClicks?.iconClickTracking[0].iconClickTrackingId)
        
    }
    
    func testAdNonLinear() throws {
        let adVast = """
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
        let vastParser = VastParser(contents: adVast)
        let success = vastParser.parse()
        XCTAssertTrue(success)
        
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads)
        
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear.count)
        
        XCTAssertEqual(350, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].width)
        
         XCTAssertEqual(350, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].height)
        
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickThrough)
        
        XCTAssertEqual("https://iabtechlab.com", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickThrough?.uri)
     
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickTracking.count)
        
        XCTAssertEqual("https://example.com/tracking/clickTracking", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].nonlinarads?.nonlinear[0].nonLinearClickTracking[0].uri)
    }
    
    func testAdCompanion() throws {
        let adVast = """
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
                      <AltText>Comp</AltText>
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
        
        let vastParser = VastParser(contents: adVast)
        let success = vastParser.parse()
        XCTAssertTrue(success)
        
        XCTAssertEqual(2, vastParser.state.vast.vastAd?.vastInline?.creatives.creative.count)
        
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds)
        
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion.count)
        
        XCTAssertEqual("Comp", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].altText?.value)
        
        XCTAssertEqual("https://iabtechlab.com", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].companionClickThrough?.uri)
        
        // TrackingEvents
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[1].linear?.trackingEvents)
        XCTAssertNil(vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].trackingEvents)
        
        XCTAssertEqual(6, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[1].linear?.trackingEvents?.trackingEvent.count)
        XCTAssertEqual("start", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[1].linear?.trackingEvents?.trackingEvent[0].event)
        XCTAssertEqual("https://example.com/tracking/start", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[1].linear?.trackingEvents?.trackingEvent[0].uri)
        XCTAssertEqual("firstQuartile", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[1].linear?.trackingEvents?.trackingEvent[2].event)
        
        // StaticResource
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].staticResource.count)
        XCTAssertEqual("image/png", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].staticResource[0].creativeType)
        XCTAssertEqual("https://www.iab.com/wp-content/uploads/2014/09/iab-tech-lab-6-644x290.png", vastParser.state.vast.vastAd?.vastInline?.creatives.creative[0].companionAds?.companion[0].staticResource[0].uri)
    }
    
    func testAdVerification() {
        let adVast = """
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
        let vastParser = VastParser(contents: adVast)
        let success = vastParser.parse()
        XCTAssertTrue(success)
        
        // AdVerifications
        // Verfication
        // JavaScriptResource
        XCTAssertNotNil(vastParser.state.vast.vastAd?.vastInline?.adVerifications)
        XCTAssertEqual(2, vastParser.state.vast.vastAd?.vastInline?.adVerifications?.verification.count)
        XCTAssertEqual(1, vastParser.state.vast.vastAd?.vastInline?.adVerifications?.verification[0].javaScriptResource.count)
        XCTAssertEqual("https://verificationcompany1.com/verification_script1.js", vastParser.state.vast.vastAd?.vastInline?.adVerifications?.verification[0].javaScriptResource[0].uri)
        
    }
 

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}
