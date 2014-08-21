//
//  ESSolicitud.m
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESSolicitud.h"

@implementation ESSolicitud

+(ESSolicitud *)lazySolicitud {
    ESSolicitud *solicitud = [ESSolicitud new];
    
    solicitud.comentario = @"Excelente trabajo";
    solicitud.cliente = [ESCliente lazyCliente];
    
    return  solicitud;
}

@end
