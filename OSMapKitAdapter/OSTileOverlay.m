//
//  OSTileOverlay.m
//  OSMapKitAdapter
//
//  Created by Dave Hardiman on 06/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSTileOverlay.h"

NSString *const _OSURLTemplate = @"https://api.ordnancesurvey.co.uk/mapping_api/"
                                  "service/zxy/EPSG%%3A900913/%@/{z}/{x}/{y}.png"
                                  "?apikey=%@";

@implementation OSTileOverlay

+ (NSString *)urlTemplateForAPIKey:(NSString *)apiKey product:(OSMapProduct)product {
    NSString *escapedProduct = [NSStringFromOSMapProduct(product)
        stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet URLPathAllowedCharacterSet]];
    return [NSString stringWithFormat:_OSURLTemplate, escapedProduct, apiKey];
}

- (instancetype)initWithAPIKey:(NSString *)apiKey product:(OSMapProduct)product {
    NSString *template = [OSTileOverlay urlTemplateForAPIKey:apiKey product:product];
    if (self = [super initWithURLTemplate:template]) {
        self.canReplaceMapContent = YES;
    }
    return self;
}

@end
