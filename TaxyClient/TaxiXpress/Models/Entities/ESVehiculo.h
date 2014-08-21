//
//  ESVehiculo.h
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESModeloVehiculo.h"

@interface ESVehiculo : NSObject

@property(nonatomic,strong) NSString *placa;
@property(nonatomic,strong) ESModeloVehiculo *modelo;

+(ESVehiculo *)lazyVehiculo;

@end
