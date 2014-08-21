//
//  ESRootDetalleTaxistaViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 09/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESUtils.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESDetalleTaxistaViewController.h"
#import "ESMasDetalleTaxistaViewController.h"
#import "ESDetalleTaxistaSegue.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESUtils.h"

@protocol ESRootTaxiRequestDelegate <NSObject>

@required
-(void)showInfoView;
-(void)showVermasView;

@end

@interface ESRootDetalleTaxistaViewController : UIViewController
@property(nonatomic,strong) ESTaxista *taxista;
@property(nonatomic,strong) GMSMarker *taxistaMarker;
@property(nonatomic,strong) GMSMarker *clienteMarker;
@end
