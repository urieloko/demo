//
//  ESMenuTableViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias Escobar on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESLocalizableConstants.h"
#import "ESUtilConstants.h"

@interface ESMenuTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *contentsList;
@end
