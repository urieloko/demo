//
//  ESRespuestaTaxistaViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESCalificacion.h"
#import "ESTaxista.h"
#import "ESUtils.h"

@interface ESEvaluacionTaxistaViewController : UIViewController <ESStarRatingProtocol,UITextFieldDelegate>
@property (nonatomic,strong) ESTaxista *taxista;
@property (strong,nonatomic) IBOutlet UIButton *btnomitir;
@property (strong,nonatomic) IBOutlet UIButton *btncalifica;
@end
