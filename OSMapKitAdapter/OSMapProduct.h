//
//  OSMapProduct.h
//  OSMapKitAdapter
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The available map products
 */
typedef NS_ENUM(NSInteger, OSMapProduct) {
    /**
     *  Standard zoom map product
     */
    OSMapProductZoom
};

/**
 *  Return the name to use for the product
 */
NSString *NSStringFromOSMapProduct(OSMapProduct product);
