//
//  ESIcon.h
//  TaxiXpress
//
//  Created by Roy on 21/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "JSONModel.h"
#define ICON_SIZE @"64"

@interface ESIcon : JSONModel

@property(nonatomic,strong)NSString<Optional> *suffix;
@property(nonatomic,strong)NSString<Optional> *prefix;


-(BOOL)isEqual:(id)object;
-(NSUInteger)hash;

-(NSURL *)getUrl;
-(NSString *)getNameIcon;

@end
