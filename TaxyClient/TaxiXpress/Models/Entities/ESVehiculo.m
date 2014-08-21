//
//  ESVehiculo.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESVehiculo.h"

@implementation ESVehiculo

+(ESVehiculo *)lazyVehiculo {
    ESVehiculo *vehiculo = [ESVehiculo new];
    
    vehiculo.placa = @"123-QWE";
    vehiculo.modelo = [ESModeloVehiculo lazyModeloVehiculo];
    
    return vehiculo;
}

@end
