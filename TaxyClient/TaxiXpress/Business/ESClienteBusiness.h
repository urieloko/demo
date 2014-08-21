//
//  ESClienteBusiness.h
//  TaxiXpress
//
//  Created by Roy on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESFourSquareWS.h"
#import "ESGoogleMapsWS.h"

@interface ESClienteBusiness : NSObject

-(NSURLSessionDataTask *)lugaresCercanos:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(NSURLSessionDataTask *)sugerirDireccion:(ESUbicacion *)ubicacion completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

@end
