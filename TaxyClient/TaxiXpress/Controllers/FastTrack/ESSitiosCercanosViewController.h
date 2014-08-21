//
//  ESSitiosCercanosTableViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 25/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESClienteBusiness.h"

@interface ESSitiosCercanosViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) ESSearchVenues *searchVenues;
@property (strong,nonatomic) NSArray *venue;
@end
