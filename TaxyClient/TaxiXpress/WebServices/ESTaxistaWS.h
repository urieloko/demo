//
//  ESTaxistaWS.h
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESUbicacion.h"

@interface ESTaxistaWS : NSObject

-(NSURLSessionDataTask *)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(NSURLSessionDataTask *)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session;

@end
