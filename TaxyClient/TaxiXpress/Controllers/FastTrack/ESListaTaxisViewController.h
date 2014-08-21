//
//  ESListaTaxisViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTaxista.h"
#import "ESUbicacion.h"
#import "ESCalificacion.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ESListaTaxisViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,ESStarRatingProtocol>

@property(nonatomic,strong) GMSMarker *clienteMarker;
@property (nonatomic,strong) NSArray *taxista;
@property (weak, nonatomic) ESCalificacion *starRatingImage;
@end
