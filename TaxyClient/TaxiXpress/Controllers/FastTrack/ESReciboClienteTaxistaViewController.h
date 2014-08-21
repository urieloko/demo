//
//  ESReciboClienteTaxistaViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESTaxista.h"

@interface ESReciboClienteTaxistaViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *taxistaImg;
@property (strong, nonatomic) IBOutlet UILabel *nombreLbl;
@property (strong, nonatomic) IBOutlet UILabel *placasLbl;
@property (strong, nonatomic) IBOutlet UILabel *modeloLbl;

@property (strong,nonatomic) ESTaxista *taxista;
@end
