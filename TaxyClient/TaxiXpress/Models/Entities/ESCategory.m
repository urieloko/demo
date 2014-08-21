//
//  ESCategory.m
//  TaxiXpress
//
//  Created by Roy on 21/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESCategory.h"

@implementation ESCategory

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"idCategory"}];
}

@end
