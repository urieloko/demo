//
//  ESCliente.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESCliente.h"

@implementation ESCliente

+(ESCliente *)lazyCliente {
    ESCliente *cliente = [ESCliente new];
    
    cliente.nombre = @"Homero";
    cliente.apellidos = @"Simpson";
    
    return cliente;
}

@end
