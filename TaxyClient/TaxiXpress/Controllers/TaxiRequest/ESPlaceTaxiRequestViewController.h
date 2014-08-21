//
//  ESPlaceTaxiRequestViewController.h
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ESClienteBusiness.h"
#import "ESFoursquareBusiness.h"
#import "ESRootTaxiRequestViewController.h"

@interface ESPlaceTaxiRequestViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *venue;
@property (strong, nonatomic) ESVenue *venueSelected;
@property (strong, nonatomic) ESFoursquareBusiness *foursquareBusiness;
@property (strong, nonatomic) id<ESRootTaxiRequestDelegate>delegate;


-(void)cleanPlaces;
-(void)requestPlacesWithSearchVenue:(ESSearchVenues *)searchVenues;
-(void)cancelRequestPlaces;
-(void)showProgress;
-(void)hideProgress;
@end
