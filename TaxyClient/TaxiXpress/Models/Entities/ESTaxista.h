//
//  ESTaxista.h
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESUsuario.h"
#import "ESSolicitud.h"
#import "ESVehiculo.h"
#import "ESUbicacion.h"

@interface ESTaxista : ESUsuario

@property(nonatomic,strong) NSString *idTaxista;
@property(nonatomic,strong) UIImage *imagen;
@property(nonatomic,strong) ESVehiculo *vehiculo;
@property(nonatomic,strong) NSArray *solicitud;
@property(nonatomic,strong) ESUbicacion *ubicacion;

+(ESTaxista *)lazyTaxista;

@end
