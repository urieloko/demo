//
//  ESFourSquareWS.m
//  TaxiXpress
//
//  Created by Roy on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESFourSquareWS.h"

@implementation ESFourSquareWS

-(NSURLSessionDataTask *)searchPlacesWithSearchVenue:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    return [self searchPlacesWithSearchVenue:searchVenues completionHandler:completionBlock errorHandler:errorBlock session:[NSURLSession sharedSession]];
}

-(NSURLSessionDataTask *)searchPlacesWithSearchVenue:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock session:(NSURLSession *)session {
    NSString *urlStr = nil;
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    NSURLSessionDataTask *task = nil;
    
    urlStr = [NSString stringWithFormat:FS_URL,searchVenues.clientId,searchVenues.clientSecret,searchVenues.version,searchVenues.coordinate.latitude,searchVenues.coordinate.longitude];
    
    NSLog(@"FS URL: %@",urlStr);
    
    url = [NSURL URLWithString:urlStr];
    
    request = [[NSURLRequest requestWithURL:url] mutableCopy];
               
    task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSArray *venues = nil;
        NSDictionary *dicResponse = nil;
        ESVenueResponse *venuesResponse = nil;
        
        if (!error) {
            dicResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            NSLog(@"FS RESPONSE: %@",dicResponse);
            
            if (!error) {
                venuesResponse = [[ESVenueResponse alloc] initWithDictionary:dicResponse[@"response"] error:&error];
                venues = error ? nil : venuesResponse.venues;
            }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (error) {
                errorBlock(error);
            } else {
                completionBlock(venues);
            }
        }];
    }];
    
    return task;
}

@end
