//
//  ViewController.m
//  MapKitExampleObjC
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
@import OSMapKitAdapter;
@import OSGridPointConversion;

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) MKCoordinateRegion nationalGridSpan;
@property (assign, nonatomic) CLLocationCoordinate2D topLeftCoordinate;
@property (assign, nonatomic) CLLocationCoordinate2D bottomRightCoordinate;
@property (assign, nonatomic) BOOL blockMove;
@end

@implementation ViewController

- (NSString *)apiKey {
    return [NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"APIKEY" withExtension:nil]
                                    encoding:NSUTF8StringEncoding
                                       error:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    OSTileOverlay *tileOverlay = [[OSTileOverlay alloc] initWithAPIKey:self.apiKey
                                                               product:OSMapProductZoom];

    self.topLeftCoordinate = OSCoordinateForGridPoint(OSGridPointMake(0, OSGridHeight));
    self.bottomRightCoordinate = OSCoordinateForGridPoint(OSGridPointMake(OSGridWidth, 0));

    tileOverlay.clipOverlay = NO; // YES allows the overlay to render alongside other maps,
                                  // NO replaces all MapKit content

    [self.mapView addOverlay:tileOverlay];
    self.mapView.delegate = self;
    //    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(50.9386, -1.4705);
    //    self.mapView.region = MKCoordinateRegionMake(self.mapView.centerCoordinate, MKCoordinateSpanMake(2, 2));
    OSCoordinateRegion uk = OSCoordinateRegionForGridRect(OSGridRectMake(0, 0, OSGridWidth, OSGridHeight));
    OSCoordinateRegion zoomedUK = OSCoordinateRegionForGridRect(OSGridRectMake(0, 0, OSGridWidth - 200000, OSGridHeight - 200000));
    MKCoordinateRegion region = {
        uk.center,
        MKCoordinateSpanMake(uk.span.latitudeDelta, uk.span.longitudeDelta)};
    self.nationalGridSpan = region;
    NSValue *castValue = [NSValue value:&zoomedUK withObjCType:@encode(OSCoordinateRegion)];
    MKCoordinateRegion viewRegion;
    [castValue getValue:&viewRegion];
    self.mapView.region = viewRegion;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:MKTileOverlay.class]) {
        return [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay];
    } else {
        return [[MKOverlayRenderer alloc] initWithOverlay:overlay];
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (self.blockMove) {
        self.blockMove = NO;
        return;
    }
    MKCoordinateRegion currentRegion = mapView.region;
    bool changeRegionLong = YES;
    bool changeRegionLat = YES;
    // LONGITUDE
    if ((currentRegion.center.longitude - (currentRegion.span.longitudeDelta / 2)) < self.topLeftCoordinate.longitude) {
        currentRegion.center.longitude = (self.topLeftCoordinate.longitude + (currentRegion.span.longitudeDelta / 2));
    } else if ((currentRegion.center.longitude + (currentRegion.span.longitudeDelta / 2)) > self.bottomRightCoordinate.longitude) {
        currentRegion.center.longitude = (self.bottomRightCoordinate.longitude - (currentRegion.span.longitudeDelta / 2));
    } else {
        changeRegionLong = NO;
    }

    // LATITUDE
    if ((currentRegion.center.latitude + (currentRegion.span.latitudeDelta / 2)) > self.topLeftCoordinate.latitude) {
        currentRegion.center.latitude = (self.topLeftCoordinate.latitude - (currentRegion.span.latitudeDelta / 2));
    } else if ((currentRegion.center.latitude - (currentRegion.span.latitudeDelta / 2)) < self.bottomRightCoordinate.latitude) {
        currentRegion.center.latitude = (self.bottomRightCoordinate.latitude + (currentRegion.span.latitudeDelta / 2));
    } else {
        changeRegionLat = NO;
    }

    if (changeRegionLong || changeRegionLat) {
        self.blockMove = YES;
        [mapView setRegion:currentRegion animated:YES];
    }
}

@end
