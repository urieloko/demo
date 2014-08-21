//
//  ESGoogleMapsWS.m
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESGoogleMapsWS.h"

@implementation ESGoogleMapsWS

-(NSURLSessionDataTask *)searchAddressWithSearchVenue:(ESUbicacion *)ubicacion completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    return [self searchAddressWithSearchVenue:ubicacion completionHandler:completionBlock errorHandler:errorBlock session:[NSURLSession sharedSession]];
}

-(NSURLSessionDataTask *)searchAddressWithSearchVenue:(ESUbicacion *)ubicacion completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session {
    NSString *urlStr = nil;
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    NSURLSessionDataTask *task = nil;
    
    urlStr = [NSString stringWithFormat:GM_URL_GEOCODE_LAT_LNG,ubicacion.latitud,ubicacion.longitud];
    
    NSLog(@"GM GEOCODE URL LAT,LNG: %@",urlStr);
    
    url = [NSURL URLWithString:urlStr];
    
    request = [[NSURLRequest requestWithURL:url] mutableCopy];
    
    task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSString *jsonResponse = nil;
        ESAddressResponse *addressResponse = nil;
        
        if (!error) {
            jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"GM GEOCODE RESPONSE: %@",jsonResponse);
            
            addressResponse = [[ESAddressResponse alloc] initWithString:jsonResponse error:&error];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error && errorBlock) {
                errorBlock(error);
            } else if (completionBlock){
                completionBlock(addressResponse.results);
            }
        }];
    }];
    
    return task;
}

-(NSURLSessionDataTask *)searchAddressWithAddress:(ESAddress *)address completionHandler:(void (^)(NSArray *addresses)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    
    return [self searchAddressWithAddress:address completionHandler:completionBlock errorHandler:errorBlock session:[NSURLSession sharedSession]];
}

-(NSURLSessionDataTask *)searchAddressWithAddress:(ESAddress *)address completionHandler:(void (^)(NSArray *addresses)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session {
    NSString *urlStr = nil;
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    NSURLSessionDataTask *task = nil;
    
    urlStr = [NSString stringWithFormat:GM_URL_GEOCODE_ADDRESS,address.formatted_address];
    
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"URL with URLQueryAllowedCharacterSet: %@",urlStr);
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"GM GEOCODE URL ADDRESS: %@",urlStr);
    
    url = [NSURL URLWithString:urlStr];
    
    request = [[NSURLRequest requestWithURL:url] mutableCopy];
    
    task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSString *jsonResponse = nil;
        ESAddressResponse *addressResponse = nil;
        
        if (!error) {
            jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"GM GEOCODE RESPONSE: %@",jsonResponse);
            
            addressResponse = [[ESAddressResponse alloc] initWithString:jsonResponse error:&error];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error && errorBlock) {
                errorBlock(error);
            } else if (completionBlock){
                completionBlock(addressResponse.results);
            }
        }];
    }];
    
    return task;
}

@end
