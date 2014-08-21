//
//  ESVenue.h
//  TaxiXpress
//
//  Created by Roy on 30/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "JSONModel.h"
#import "ESUbicacion.h"
#import "ESCategory.h"

@protocol ESVenue <NSObject>
@end

@interface ESVenue : JSONModel

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)ESUbicacion *location;
@property(nonatomic,strong) NSArray<ESCategory> *categories;

@end