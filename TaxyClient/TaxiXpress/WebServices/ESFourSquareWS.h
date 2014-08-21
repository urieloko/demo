//
//  ESFourSquareWS.h
//  TaxiXpress
//
//  Created by Roy on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESSearchVenues.h"
#import "ESVenueResponse.h"

@interface ESFourSquareWS : NSObject

-(NSURLSessionDataTask *)searchPlacesWithSearchVenue:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(NSURLSessionDataTask *)searchPlacesWithSearchVenue:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session;

@end
