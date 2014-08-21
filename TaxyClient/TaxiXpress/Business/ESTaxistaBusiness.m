//
//  ESTaxistaBusiness.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESTaxistaBusiness.h"
#import "ESCliente.h"
#import "ESSolicitud.h"
#import "ESTaxistaWS.h"

@implementation ESTaxistaBusiness

-(NSURLSessionDataTask *)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *posicionTaxi)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock
{
    NSURLSessionDataTask *task = nil;
    ESTaxistaWS *taxistaWS = nil;
    
    taxistaWS = [ESTaxistaWS new];
    
    task = [taxistaWS posicionTaxisCercanos:posicionCliente completionHandler:completionBlock errorHandler:errorBlock];
    
    return task;
}

//-(void)posicionTaxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *taxistas)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
//    
//    ESUbicacion *pos1 = [ESUbicacion new];
//    ESUbicacion *pos2 = [ESUbicacion new];
//    ESUbicacion *pos3 = [ESUbicacion new];
//    NSArray *posicionTaxi = nil;
//    
//    pos1.latitud = posicionCliente.latitud + 0.003;
//    pos1.longitud = posicionCliente.longitud;
//    
//    pos2.latitud = posicionCliente.latitud;
//    pos2.longitud = posicionCliente.longitud + 0.004;
//    
//    pos3.latitud = posicionCliente.latitud + 0.002;
//    pos3.longitud = posicionCliente.longitud + 0.003;
//    
//    posicionTaxi = @[pos1,pos2,pos3];
//    
//    completionBlock(posicionTaxi);
//}


-(void)taxisCercanos:(ESUbicacion *)posicionCliente completionHandler:(void (^)(NSArray *posicionTaxi)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    
    dispatch_queue_t dqt = dispatch_queue_create("taxisCercanos", NULL);
    
    dispatch_async(dqt, ^{
        ESTaxista *taxi1 = [ESTaxista lazyTaxista];
        ESTaxista *taxi2 = [ESTaxista lazyTaxista];
        ESTaxista *taxi3 = [ESTaxista lazyTaxista];
        
        taxi1.imagen = [UIImage imageNamed:@"taxista1.png"];
        taxi2.imagen = [UIImage imageNamed:@"taxista2.png"];
        taxi3.imagen = [UIImage imageNamed:@"taxista3.png"];
        
        NSArray *taxis = @[taxi1,taxi2,taxi3];
        
        sleep(3);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(taxis);
        });
    });
}

-(void)infoTaxista:(ESTaxista *)taxista completionHandler:(void (^)(ESTaxista *taxista)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock {
    dispatch_queue_t dqt = dispatch_queue_create("infoTaxista", NULL);
    
    dispatch_async(dqt, ^{
        ESTaxista *taxi1 = [ESTaxista lazyTaxista];
        
        taxi1.imagen = [UIImage imageNamed:@"taxista2.png"];
        
        sleep(3);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(taxi1);
        });
    });
}


@end
