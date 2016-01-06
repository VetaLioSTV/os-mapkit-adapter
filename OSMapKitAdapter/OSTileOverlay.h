//
//  OSTileOverlay.h
//  OSMapKitAdapter
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

@import MapKit;
#import "OSMapProduct.h"

/**
 *  Tile overlay subclass to use to connect to OS Maps API
 */
@interface OSTileOverlay : MKTileOverlay

/**
 *  Designated initialiser
 *
 *  @param apiKey  The OS Maps API key to use
 *  @param product The map product you wish to use
 *
 *  @return An initialised OSTileOverlay
 */
- (instancetype)initWithAPIKey:(NSString *)apiKey product:(OSMapProduct)product NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithURLTemplate:(NSString *)URLTemplate NS_UNAVAILABLE;

@end
