//
//  ESMasDetalleTaxistaViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 09/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTaxista.h"
#import "ESUtils.h"
#import "UIViewController+ESTaxiXpressViewController.h"

@interface ESMasDetalleTaxistaViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableViewComentarios;
@property(nonatomic,strong) ESTaxista *taxista;
@property (strong,nonatomic) IBOutlet UILabel *lblAbordo;
@property (strong,nonatomic) IBOutlet UILabel *lblComentario;
@property (strong,nonatomic) IBOutlet UILabel *lblTarifa;

@end
