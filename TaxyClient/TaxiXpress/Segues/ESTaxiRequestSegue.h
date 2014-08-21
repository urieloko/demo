//
//  ESTaxiRequestSegue.h
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const SG_ID_MAP;
extern NSString * const SG_ID_PLACE;

@class ESRootTaxiRequestViewController;

@interface ESTaxiRequestSegue : UIStoryboardSegue

@property (strong) void(^performBlock)( ESTaxiRequestSegue* segue, UIViewController* tabVC);

@end
