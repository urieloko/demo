//
//  ESTaxistaBusiness.h
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESUbicacion.h"
#import "ESTaxista.h"

@interface ESTaxistaBusiness : NSObject

-(NSURLSessionDataTask *)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *posicionTaxi)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

//-(void)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *posicionTaxi)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(void)taxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *taxistas)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

-(void)infoTaxista:(ESTaxista *)taxista completionHandler:(void (^)(ESTaxista *taxista)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;

@end
