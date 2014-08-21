//
//  ESModeloVehiculo.h
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESMarcaVehiculo.h"

@interface ESModeloVehiculo : NSObject

@property(nonatomic,strong) NSString *idModeloVehiculo;
@property(nonatomic,strong) NSString *descripcion;
@property(nonatomic,strong) ESMarcaVehiculo *marcaVehiculo;

+(ESModeloVehiculo *)lazyModeloVehiculo;

@end
