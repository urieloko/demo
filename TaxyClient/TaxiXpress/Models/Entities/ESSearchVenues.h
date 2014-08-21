//
//  ESSearchVenues.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 25/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ESWebServiceConstants.h"

@interface ESSearchVenues : NSObject

@property (nonatomic,strong)NSString *clientId;
@property (nonatomic,strong)NSString *clientSecret;
@property (nonatomic,strong)NSString *version;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

-(id)initWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret version:(NSString *)version coordinate:(CLLocationCoordinate2D)coordinate;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
