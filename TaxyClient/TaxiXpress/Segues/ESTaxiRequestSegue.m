//
//  ESTaxiRequestSegue.m
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESTaxiRequestSegue.h"
#import "ESRootTaxiRequestViewController.h"

NSString * const SG_ID_MAP = @"map";
NSString * const SG_ID_PLACE = @"place";

@interface ESTaxiRequestSegue ()
-(void)perform;
@end

@implementation ESTaxiRequestSegue

-(void)perform
{
    if (_performBlock) {
        _performBlock(self,self.destinationViewController);
    }
}

@end
