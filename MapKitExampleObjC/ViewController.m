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

@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OSTileOverlay *tileOverlay = [[OSTileOverlay alloc] initWithAPIKey:@""
                                                              products:OSMapProductZoom];
    [self.mapView addOverlay:tileOverlay];
    self.mapView.delegate = self;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(50.9386, -1.4705);
    self.mapView.region = MKCoordinateRegionMake(self.mapView.centerCoordinate, MKCoordinateSpanMake(2, 2));
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:MKTileOverlay.class]) {
        return [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay];
    } else {
        return [[MKOverlayRenderer alloc] initWithOverlay:overlay];
    }
}

@end
