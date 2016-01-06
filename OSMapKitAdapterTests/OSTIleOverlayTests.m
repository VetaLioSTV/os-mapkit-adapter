//
//  OSTIleOverlayTests.m
//  OSMapKitAdapter
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

@import MIQTestingFramework;
@import OSMapKitAdapter;

@interface OSTIleOverlayTests : XCTestCase

@end

@implementation OSTIleOverlayTests

- (void)testATileOverlayHasAURLTemplate {
    OSTileOverlay *tileOverlay = [[OSTileOverlay alloc] initWithAPIKey:@"test-key" product:OSMapProductZoom];
    expect(tileOverlay.URLTemplate).to.equal(@"https://api.ordnancesurvey.co.uk/mapping_api/service/zxy/EPSG%3A900913/Zoom%20Map%203857/{z}/{x}/{y}.png?apikey=test-key");
}

- (void)testTheOverlayIntendsToReplaceContent {
    OSTileOverlay *tileOverlay = [[OSTileOverlay alloc] initWithAPIKey:@"test-key" product:OSMapProductZoom];
    expect(tileOverlay.canReplaceMapContent).to.beTruthy();
}

@end
