//
//  ESDetalleTaxistaViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTaxista.h"
#import "ESCalificacion.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ESLocalizableConstants.h"

@interface ESDetalleTaxistaViewController : UIViewController <ESStarRatingProtocol>
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UIImageView *taxistaImg;
@property (strong, nonatomic) IBOutlet UILabel *lblPlacas;
@property (strong, nonatomic) IBOutlet UILabel *lblModelo;
@property (strong, nonatomic) IBOutlet UILabel *lblPermite;
@property (weak, nonatomic) IBOutlet ESCalificacion *starRatingImage;
@property (strong,nonatomic) IBOutlet UILabel *lblServicio;
@property (strong,nonatomic) IBOutlet UIButton *btnPedirTaxi;

@property(nonatomic,strong) ESTaxista *taxista;
@property(nonatomic,strong) GMSMarker *taxistaMarker;
@property(nonatomic,strong) GMSMarker *clienteMarker;

@end
