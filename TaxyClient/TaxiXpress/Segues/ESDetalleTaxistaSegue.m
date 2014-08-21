//
//  ESDetalleTaxistaSegue.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 09/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESDetalleTaxistaSegue.h"
#import "ESRootDetalleTaxistaViewController.h"

NSString * const SG_ID_INFO = @"info";
NSString * const SG_ID_VERMAS = @"vermas";

@interface ESDetalleTaxistaSegue ()
-(void)perform;
@end

@implementation ESDetalleTaxistaSegue

-(void)perform
{
    if (_performBlock) {
        _performBlock(self,self.destinationViewController);
    }
}
@end

