//
//  ESTaxista.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESTaxista.h"

@implementation ESTaxista

+(ESTaxista *)lazyTaxista {
    ESTaxista *taxista = [ESTaxista new];
    
    taxista.idTaxista = @"XYZWWW";
    taxista.nombre = @"Andres";
    taxista.apellidos = @"Perez";
    taxista.vehiculo = [ESVehiculo lazyVehiculo];
    taxista.solicitud = @[[ESSolicitud lazySolicitud],[ESSolicitud lazySolicitud],[ESSolicitud lazySolicitud]];
    
    return taxista;
}

@end
