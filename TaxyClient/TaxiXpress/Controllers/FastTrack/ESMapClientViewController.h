//
//  ESMapClientViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESTaxista;
@class ESVenue;

@interface ESMapClientViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (strong,nonatomic) NSString *action;
@property(nonatomic,strong) NSArray *taxistas;
@property(nonatomic,strong) ESTaxista *taxista;
@property (strong, nonatomic) ESVenue *venue;
@property (strong, nonatomic) NSArray *venues;


@property (strong, nonatomic) IBOutlet UIButton *origenButton;

@end
