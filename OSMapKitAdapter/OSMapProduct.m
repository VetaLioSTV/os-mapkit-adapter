//
//  OSMapProduct.m
//  OSMapKitAdapter
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSMapProduct.h"

NSString *NSStringFromOSMapProduct(OSMapProduct product) {
    switch (product) {
        case OSMapProductZoom:
            return @"Zoom Map 3857";
    }
}
