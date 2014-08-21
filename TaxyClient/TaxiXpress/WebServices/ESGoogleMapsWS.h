//
//  ESGoogleMapsWS.h
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESUbicacion.h"
#import "ESAddressResponse.h"
#import "ESWebServiceConstants.h"

@interface ESGoogleMapsWS : NSObject

-(NSURLSessionDataTask *)searchAddressWithSearchVenue:(ESUbicacion *)ubicacion completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(NSURLSessionDataTask *)searchAddressWithSearchVenue:(ESUbicacion *)ubicacion completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session;

-(NSURLSessionDataTask *)searchAddressWithAddress:(ESAddress *)address completionHandler:(void (^)(NSArray *addresses)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(NSURLSessionDataTask *)searchAddressWithAddress:(ESAddress *)address completionHandler:(void (^)(NSArray *addresses)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session;

@end
