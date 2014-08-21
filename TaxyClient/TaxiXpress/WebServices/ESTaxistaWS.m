//
//  ESTaxistaWS.m
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESTaxistaWS.h"

@implementation ESTaxistaWS

-(NSURLSessionDataTask *)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock
{
    return [self posicionTaxisCercanos:posicionCliente completionHandler:completionBlock errorHandler:errorBlock session:[NSURLSession sharedSession]];
}

-(NSURLSessionDataTask *)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *address)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session
{
    NSString *urlStr = nil;
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    NSURLSessionDataTask *task = nil;

    urlStr = @"https://www.google.com.mx";
//    urlStr = [NSString stringWithFormat:GM_URL_GEOCODE,ubicacion.latitud,ubicacion.longitud];
    
    NSLog(@"posicionTaxisCercanos: URL: %@",urlStr);
    
    url = [NSURL URLWithString:urlStr];
    
    request = [[NSURLRequest requestWithURL:url] mutableCopy];
    
    task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSString *jsonResponse = nil;
//        ESAddressResponse *addressResponse = nil;
        
        if (!error) {
//            jsonResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"GM GEOCODE RESPONSE: %@",jsonResponse);
//            
//            addressResponse = [[ESAddressResponse alloc] initWithString:jsonResponse error:&error];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error && errorBlock) {
                errorBlock(error);
            } else if (completionBlock){
                ESUbicacion *pos1 = [ESUbicacion new];
                ESUbicacion *pos2 = [ESUbicacion new];
                ESUbicacion *pos3 = [ESUbicacion new];
                NSArray *posicionTaxi = nil;
                
                pos1.latitud = posicionCliente.latitud + 0.003;
                pos1.longitud = posicionCliente.longitud;
                
                pos2.latitud = posicionCliente.latitud;
                pos2.longitud = posicionCliente.longitud + 0.004;
                
                pos3.latitud = posicionCliente.latitud + 0.002;
                pos3.longitud = posicionCliente.longitud + 0.003;
                
                posicionTaxi = @[pos1,pos2,pos3];
                
                completionBlock(posicionTaxi);

//                completionBlock(addressResponse.results);
            }
        }];
    }];
    
    return task;
}

@end
