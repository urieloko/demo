//
//  ESClienteBusiness.m
//  TaxiXpress
//
//  Created by Roy on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESClienteBusiness.h"

@implementation ESClienteBusiness

-(NSURLSessionDataTask *)lugaresCercanos:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    
    ESFourSquareWS *fourSquareWS = [ESFourSquareWS new];
    
    return [fourSquareWS searchPlacesWithSearchVenue:searchVenues completionHandler:completionBlock errorHandler:errorBlock];
}

-(NSURLSessionDataTask *)sugerirDireccion:(ESUbicacion *)ubicacion completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    ESGoogleMapsWS *googleMaps = [ESGoogleMapsWS new];
    
    return [googleMaps searchAddressWithSearchVenue:ubicacion completionHandler:completionBlock errorHandler:errorBlock];
}

@end