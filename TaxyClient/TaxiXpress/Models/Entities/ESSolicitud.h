//
//  ESSolicitud.h
//  TaxiXpress
//
//  Created by Roy on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESCliente.h"

@interface ESSolicitud : NSObject

@property(nonatomic,strong) NSString *idSolicitud;
@property(nonatomic,strong) ESCliente *cliente;
@property(nonatomic,strong) NSString *comentario;

+(ESSolicitud *)lazySolicitud;

@end
