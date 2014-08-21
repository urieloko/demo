//
//  ESUbicacionUsuario.m
//  TaxiXpress
//
//  Created by Roy on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESUbicacion.h"

@implementation ESUbicacion

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"lat": @"latitud",@"lng": @"longitud",@"address":@"direccion"}];
}

-(id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate {
    
    self = [super init];
    
    if (self) {
        _latitud = coordinate.latitude;
        _longitud = coordinate.longitude;
    }
    
    return self;
}

@end

@implementation ESGeometry

@end
