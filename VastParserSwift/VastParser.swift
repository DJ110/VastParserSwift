//
//  VastParser.swift
//  VastParserSwift
//
//  Created by 伊藤大司 on 7/9/20.
//  Copyright © 2020 DJ110. All rights reserved.
//

import Foundation

open class VastParser : NSObject, XMLParserDelegate {
    
    // TODO : CreativeExtension, Extension
    
    var data : Data?
    
    var elementHandler : [String : ElementHandler] = [:]
    
    var valueHandler : [String : ValueHandler] = [:]
    
    public var state : ParseState = ParseState()
    
    private var success : Bool = true
    
    var vast : Vast {
        get {
            state.vast
        }
    }
    
    override init() {
        super.init()
        self.prepareHandler()
    }
    
    init(contents: Data) {
        self.data = contents
        super.init()
        self.prepareHandler()
    }
    
    init(contents: String) {
        self.data = contents.data(using: .utf8)
        super.init()
        self.prepareHandler()
    }
    
    func prepareHandler() {
        self.elementHandler[Constants.Element.VAST] = VASTElementHandler()
        self.elementHandler[Constants.Element.ERROR] = ErrorElementHandler()
        self.elementHandler[Constants.Element.AD] = AdElementHandler()
        self.elementHandler[Constants.Element.INLINE] = InLineElementHandler()
        self.elementHandler[Constants.Element.WRAPPER] = WrapperElementHandler()
        self.elementHandler[Constants.Element.ADSYSTEM] = AdSystemElementHandler()
        self.elementHandler[Constants.Element.ADTITLE] = AdTitleElementHandler()
        self.elementHandler[Constants.Element.ADSERVINGID] = AdServingIdElementHandler()
        self.elementHandler[Constants.Element.IMPRESSION] = ImpressionElementHandler()
        self.elementHandler[Constants.Element.CATEGORY] = CategoryElementHandler()
        self.elementHandler[Constants.Element.DESCRIPTION] = DescriptionElementHandler()
        self.elementHandler[Constants.Element.ADVERTISER] = AdvertiserElementHandler()
        self.elementHandler[Constants.Element.PRICING] = PriceElementHandler()
        self.elementHandler[Constants.Element.SURVEY] = SurveyElementHandler()
        self.elementHandler[Constants.Element.EXPIRES] = ExpiresElementHandler()
        self.elementHandler[Constants.Element.VIEWABLEIMPRESSION] = ViewableImpressionElementHandler()
        self.elementHandler[Constants.Element.VIEWABLE] = ViewableElementHandler()
        self.elementHandler[Constants.Element.NOTVIEWABLE] = NotViewableElementHandler()
        self.elementHandler[Constants.Element.VIEWUNDETERMINED] = ViewUndeterminedElementHandler()
        self.elementHandler[Constants.Element.CREATIVES] = CreativesElementHandler()
        self.elementHandler[Constants.Element.CREATIVE] = CreativeElementHandler()
        self.elementHandler[Constants.Element.UNIVERSALADID] = UniversalAdidElementHandler()
        self.elementHandler[Constants.Element.CREATIVEEXTENSIONS] = CreativeExtensionsElementHandler()
        self.elementHandler[Constants.Element.CREATIVEEXTENSION] = CreativeExtensionElementHandler()
        self.elementHandler[Constants.Element.LINEAR] = LinearElementHandler()
        self.elementHandler[Constants.Element.DURATION] = DurationElementHandler()
        self.elementHandler[Constants.Element.ADPAREMETERS] = AdParametersElementHandler()
        self.elementHandler[Constants.Element.MEDIAFILES] = MediaFilesElementHandler()
        self.elementHandler[Constants.Element.MEDIAFILE] = MediaFileElementHandler()
        self.elementHandler[Constants.Element.MEZZANINE] = MezzanineElementHandler()
        self.elementHandler[Constants.Element.INTERACTIVECREATIVEFILE] = InteractiveCreativeFileElementHandler()
        self.elementHandler[Constants.Element.CLOSEDCAPTIONFILES] = ClosedCaptionFilesElementHandler()
        self.elementHandler[Constants.Element.CLOSEDCAPTIONFILE] = ClosedCaptionFileElementHandler()
        self.elementHandler[Constants.Element.VIDEOCLICKS] = VideoClicksElementHandler()
        self.elementHandler[Constants.Element.CLICKTHROUGH] = ClickThroughElementHandler()
        self.elementHandler[Constants.Element.CLICKTRACKING] = ClickTrackingElementHandler()
        self.elementHandler[Constants.Element.CUSTOMCLICK] = CustomClickElementHandler()
        self.elementHandler[Constants.Element.ICONS] = IconsElementHandler()
        self.elementHandler[Constants.Element.ICON] = IconElementHandler()
        self.elementHandler[Constants.Element.ICONVIEWTRACKING] = IconViewTrackingElementHandler()
        self.elementHandler[Constants.Element.ICONCLICKS] = IconClicksElementHandler()
        self.elementHandler[Constants.Element.ICONCLICKTHROUGH] = IconClickThroughElementHandler()
        self.elementHandler[Constants.Element.ICONCLICKTRACKING] = IconClickTrackingElementHandler()
        self.elementHandler[Constants.Element.NONLINEARADS] = NonLinearAdsElementHandler()
        self.elementHandler[Constants.Element.NONLINEAR] = NonLinearElementHandler()
        self.elementHandler[Constants.Element.NONLINEARCLICKTHROUGH] = NonLinearClickThroughElementHandler()
        self.elementHandler[Constants.Element.NONLINEARCLICKTRACKING] = NonLinearClickTrackingElementHandler()
        self.elementHandler[Constants.Element.COMPANIONADS] = CompanionAdsElementHandler()
        self.elementHandler[Constants.Element.COMPANION] = CompanionElementHandler()
        self.elementHandler[Constants.Element.ALTTEXT] = AltTextElementHandler()
        self.elementHandler[Constants.Element.COMPANIONCLICKTHROUGH] = CompanionClickThroughElementHandler()
        self.elementHandler[Constants.Element.COMPANIONCLICKTRACKING] = CompanionClickTrackingElementHandler()
        self.elementHandler[Constants.Element.TRACKINGEVENTS] = TrackingEventsElementHandler()
        self.elementHandler[Constants.Element.TRACKING] = TrackingElementHandler()
        self.elementHandler[Constants.Element.STATICRESOURCE] = StaticResourceElementHandler()
        self.elementHandler[Constants.Element.IFRAMERESOURCE] = IFrameResourceElementHandler()
        self.elementHandler[Constants.Element.HTMLRESOURCE] = HTMLResourceElementHandler()
        self.elementHandler[Constants.Element.ADVERIFICATIONS] = AdVerificationsElementHandler()
        self.elementHandler[Constants.Element.VERIFICATION] = VerificationElementHandler()
        self.elementHandler[Constants.Element.JAVASCRIPTRESOURCE] = JavaScriptResourceElementHandler()
        self.elementHandler[Constants.Element.EXECUTABLERESOURCE] = ExecutableResourceElementHandler()
        self.elementHandler[Constants.Element.VERIFICATIONPARAMETERS] = VerificationParametersElementHandler()
        self.elementHandler[Constants.Element.EXTENSIONS] = ExtensionsElementHandler()
        self.elementHandler[Constants.Element.EXTENSION] = ExtensionElementHandler()
        self.elementHandler[Constants.Element.VASTADTAGURI] = VASTAdTagURIElementHandler()
        self.elementHandler[Constants.Element.BLOCKEDADCATEGORIES] = BlockedAdCategoriesElementHandler()
        
        // Value Handler
        self.valueHandler[Constants.Element.ERROR] = ErrorValueHandler()
        self.valueHandler[Constants.Element.ADSYSTEM] = AdSystemValueHandler()
        self.valueHandler[Constants.Element.ADTITLE] = AdTitleValueHandler()
        self.valueHandler[Constants.Element.ADSERVINGID] = AdServingIdValueHandler()
        self.valueHandler[Constants.Element.IMPRESSION] = ImpressionValueHandler()
        self.valueHandler[Constants.Element.CATEGORY] = CategoryValueHandler()
        self.valueHandler[Constants.Element.DESCRIPTION] = DescriptionValueHandler()
        self.valueHandler[Constants.Element.ADVERTISER] = AdvertiserValueHandler()
        self.valueHandler[Constants.Element.PRICING] = PriceValueHandler()
        self.valueHandler[Constants.Element.SURVEY] = SurveyValueHandler()
        self.valueHandler[Constants.Element.EXPIRES] = ExpiresValueHandler()
        self.valueHandler[Constants.Element.ADPAREMETERS] = AdParametersValueHandler()
        self.valueHandler[Constants.Element.VIEWABLE] = ViewableValueHandler()
        self.valueHandler[Constants.Element.NOTVIEWABLE] = NotViewableValueHandler()
        self.valueHandler[Constants.Element.VIEWUNDETERMINED] = ViewUndeterminedValueHandler()
        self.valueHandler[Constants.Element.UNIVERSALADID] = UniversalAdIdValueHandler()
        self.valueHandler[Constants.Element.DURATION] = DurationValueHandler()
        self.valueHandler[Constants.Element.MEDIAFILE] = MediaFileValueHandler()
        self.valueHandler[Constants.Element.MEZZANINE] = MezzanineValueHandler()
        self.valueHandler[Constants.Element.INTERACTIVECREATIVEFILE] = InteractiveCreativeFileValueHandler()
        self.valueHandler[Constants.Element.CLOSEDCAPTIONFILE] = ClosedCaptionFileValueHandler()
        self.valueHandler[Constants.Element.CLICKTHROUGH] = ClickThroughValueHandler()
        self.valueHandler[Constants.Element.CLICKTRACKING] = ClickTrackingValueHandler()
        self.valueHandler[Constants.Element.CUSTOMCLICK] = CustomClickValueHandler()
        self.valueHandler[Constants.Element.ICONVIEWTRACKING] = IconViewTrackingValueHandler()
        self.valueHandler[Constants.Element.ICONCLICKTHROUGH] = IconClickThroughValueHandler()
        self.valueHandler[Constants.Element.ICONCLICKTRACKING] = IconClickTrackingValueHandler()
        self.valueHandler[Constants.Element.NONLINEARCLICKTHROUGH] = NonLinearClickThroughValueHandler()
        self.valueHandler[Constants.Element.NONLINEARCLICKTRACKING] = NonLinearClickTrackingValueHandler()
        self.valueHandler[Constants.Element.ALTTEXT] = AltTextValueHandler()
        self.valueHandler[Constants.Element.COMPANIONCLICKTHROUGH] = CompanionClickThroughValueHandler()
        self.valueHandler[Constants.Element.COMPANIONCLICKTRACKING] = CompanionClickTrackingValueHandler()
        self.valueHandler[Constants.Element.TRACKING] = TrackingValueHandler()
        self.valueHandler[Constants.Element.STATICRESOURCE] = StaticResourceValueHandler()
        self.valueHandler[Constants.Element.IFRAMERESOURCE] = IFrameResourceValueHandler()
        self.valueHandler[Constants.Element.HTMLRESOURCE] = HTMLResourceValueHandler()
        self.valueHandler[Constants.Element.JAVASCRIPTRESOURCE] = JavaScriptResourceValueHandler()
        self.valueHandler[Constants.Element.EXECUTABLERESOURCE] = ExecutableResourceValueHandler()
        self.valueHandler[Constants.Element.VERIFICATIONPARAMETERS] = VerificationParametersValueHandler()
        self.valueHandler[Constants.Element.VASTADTAGURI] = VASTAdTagURIValueHandler()
        self.valueHandler[Constants.Element.BLOCKEDADCATEGORIES]  = BlockedAdCategoriesValueHandler()
    }
    
    func parse() -> Bool {
        guard let contents = self.data else {
            return false
        }
        let parser: XMLParser = XMLParser(data: contents)
        parser.delegate = self
        parser.parse()
        return self.success
    }
    
    // XMLParserDelegate
    public func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        // Parse
        self.elementHandler[elementName]?.execute(state: self.state, elementName: elementName, attributes: attributeDict)
        
        // Update anytime
        state.lastElement = elementName
        
        // Error Check
        errorCheck(parser: parser)
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string.trimmingCharacters(in: .whitespaces) != "\n" {
            self.valueHandler[self.state.lastElement]?.execute(state: self.state, value: string)
        }
        errorCheck(parser: parser)
    }

    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {}
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML parse error : \(parseError.localizedDescription)")
        self.success = false
    }
    
    private func showErrors() {
        for error in self.state.errors {
            print(error.message)
        }
    }
    
    private func errorCheck(parser: XMLParser) {
        // Error Check
        if (self.state.errors.count > 0) {
            // Show errors
            self.showErrors()
            self.success = false
            parser.abortParsing() // Stop Parser
        }
    }
}
