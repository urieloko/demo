//
//  ESMarcaVehiculo.h
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESMarcaVehiculo : NSObject

@property(nonatomic,strong) NSString *idMarcaVehiculo;
@property(nonatomic,strong) NSString *descripcion;

+(ESMarcaVehiculo *)lazyMarcaVehiculo;

@end
