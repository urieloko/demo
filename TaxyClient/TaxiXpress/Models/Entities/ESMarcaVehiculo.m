//
//  ESMarcaVehiculo.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESMarcaVehiculo.h"

@implementation ESMarcaVehiculo

+(ESMarcaVehiculo *)lazyMarcaVehiculo {
    ESMarcaVehiculo *marcaVehiculo = [ESMarcaVehiculo new];
    
    marcaVehiculo.descripcion = @"NISSAN";
    
    return marcaVehiculo;
}

@end
