//
//  ESUbicacionUsuario.h
//  TaxiXpress
//
//  Created by Roy on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import <CoreLocation/CoreLocation.h>


@interface ESUbicacion : JSONModel

@property(strong,nonatomic) NSString<Optional> *idUbicacion;
@property(assign,nonatomic) double latitud;
@property(assign,nonatomic) double longitud;
@property(strong,nonatomic) NSString<Optional> *direccion;
//@property(assign,nonatomic) int<Optional> distancia;

+(JSONKeyMapper *)keyMapper;
-(id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate;

@end

@interface ESGeometry : JSONModel

@property (nonatomic,strong) ESUbicacion *location;

@end
