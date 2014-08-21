//
//  ESEsperaConfirmacionViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTaxista.h"
#import "ESUbicacion.h"

@class GMSMarker;

@interface ESRespuestaTaxistaViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *taxistaImg;
@property (strong, nonatomic) IBOutlet UILabel *nombreLbl;
@property (strong, nonatomic) IBOutlet UILabel *placasLbl;
@property (strong, nonatomic) IBOutlet UILabel *modeloLbl;
@property (strong, nonatomic) IBOutlet UILabel *permiteLbl;
@property (strong, nonatomic) IBOutlet UILabel *taxistaSolicitudLbl;
@property (strong, nonatomic) IBOutlet UIButton *verTaxiCancelarBtn;

@property (strong,nonatomic) ESTaxista *taxista;
@property(nonatomic,strong) GMSMarker *taxistaMarker;
@property(nonatomic,strong) GMSMarker *clienteMarker;
@property (strong,nonatomic) NSString *respuestaTaxista;

@end
