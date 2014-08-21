//
//  ESDetalleTaxistaSegue.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 09/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const SG_ID_INFO;
extern NSString * const SG_ID_VERMAS;

@class ESRootDetalleTaxistaViewController;

@interface ESDetalleTaxistaSegue : UIStoryboardSegue

@property (strong) void(^performBlock)( ESDetalleTaxistaSegue* segue, UIViewController* tabVC);

@end




