//
//  ESNotificacion.h
//  TaxiXpress
//
//  Created by Roy on 03/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "JSONModel.h"

@interface ESNotificacion : JSONModel

@property(nonatomic,strong) NSString<Optional> *alert;
@property(nonatomic,strong) NSString<Optional> *sound;
@property(nonatomic,strong) NSString<Optional> *latitude;
@property(nonatomic,strong) NSString<Optional> *longitude;
@property(nonatomic,strong) NSString<Optional> *idDriver;
@property(nonatomic,strong) NSString<Optional> *responseDriver;

@end
