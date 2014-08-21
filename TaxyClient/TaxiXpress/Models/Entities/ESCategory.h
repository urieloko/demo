//
//  ESCategory.h
//  TaxiXpress
//
//  Created by Roy on 21/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "JSONModel.h"
#import "ESIcon.h"

@protocol ESCategory <NSObject>
@end

@interface ESCategory : JSONModel

@property(nonatomic,strong)NSString<Optional> *name;
@property(nonatomic,strong)NSString<Optional> *idCategory;
@property(nonatomic,strong)NSString<Optional> *pluralName;
@property(nonatomic,strong)NSString<Optional> *shortName;
@property(nonatomic,strong)ESIcon<Optional> *icon;

@end