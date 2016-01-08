//
//  OSTIleOverlayTests.m
//  OSMapKitAdapter
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

@import MIQTestingFramework;
@import OSMapKitAdapter;
@import MapKit;

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

- (void)testWhenSetToNotClipTheBoundingMapRectIsNull {
    OSTileOverlay *tileOverlay = [[OSTileOverlay alloc] initWithAPIKey:@"test-key" product:OSMapProductZoom];
    MKMapRect receivedRect = tileOverlay.boundingMapRect;
    expect(MKMapRectEqualToRect(receivedRect, MKMapRectWorld)).to.beTruthy();
}

- (void)testWhenSetToClipTheBoundingMapRectIsSetCorrectly {
    OSTileOverlay *tileOverlay = [[OSTileOverlay alloc] initWithAPIKey:@"test-key" product:OSMapProductZoom];
    tileOverlay.clipOverlay = YES;
    MKMapRect receivedRect = tileOverlay.boundingMapRect;
    expect(MKMapRectEqualToRect(receivedRect, OSMapRectForUK())).to.beTruthy();
}

@end
