//
//  ESSelectUserViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface ESSelectUserViewController : UIViewController <UIAlertViewDelegate>
- (void)checkForWIFIConnection;
@end
