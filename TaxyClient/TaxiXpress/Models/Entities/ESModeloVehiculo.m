//
//  ESModeloVehiculo.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESModeloVehiculo.h"

@implementation ESModeloVehiculo

+(ESModeloVehiculo *)lazyModeloVehiculo {
    ESModeloVehiculo *modelo = [ESModeloVehiculo new];
    
    modelo.descripcion = @"Platina 2013";
    modelo.marcaVehiculo = [ESMarcaVehiculo lazyMarcaVehiculo];
    
    return modelo;
}

@end
