//
//  ESAddress.h
//  TaxiXpress
//
//  Created by Rodrigo Ibáñez Jiménez on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "JSONModel.h"
#import "ESUbicacion.h"

#define STREET_NUMBER @"street_number"
#define STREET @"route"
#define STREET_ADDRESS @"street_address"

@protocol ESAddress <NSObject>
@end

@protocol ESAddressComponent <NSObject>
@end

@protocol NSString <NSObject>

@end

@interface ESAddressComponent : JSONModel

@property (nonatomic,strong) NSString<Optional> *long_name;
@property (nonatomic,strong) NSString<Optional> *short_name;
@property (nonatomic,strong) NSArray<NSString,Optional> *types;

@end

@interface ESAddress : JSONModel

@property (nonatomic,strong) NSString<Optional> *formatted_address;
@property (nonatomic,strong) NSArray<ESAddressComponent,Optional> *address_components;
@property (nonatomic,strong) ESGeometry *geometry;
@property (nonatomic,strong) NSArray<NSString,Optional> *types;

-(ESAddressComponent *) getAddressComponentOfType:(NSString *) type;

-(NSString *)getStreetOfAddress;
-(NSString *)getNumberOfAddress;
-(NSString *)getStreetNumberFormatOfAddress;

+(ESAddress *)getStreetAddress:(NSArray *)address;

@end
