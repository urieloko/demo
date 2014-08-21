//
//  ESSearchVenues.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 25/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESSearchVenues.h"

@implementation ESSearchVenues

-(id)initWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret version:(NSString *)version coordinate:(CLLocationCoordinate2D)coordinate {
    
    self = [super init];
    
    if (self) {
        _clientId = clientId;
        _clientSecret = clientSecret;
        _version = version;
        _coordinate = coordinate;
    }
    
    
    return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    return [self initWithClientId:FS_CLIENT_ID clientSecret:FS_CLIENT_SECRET version:FS_VERSION coordinate:coordinate];
}
@end


