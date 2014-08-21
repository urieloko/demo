//
//  ESRegistroClienteViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESRegistroClienteViewController : UIViewController <UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *correoTextField;
@property (strong, nonatomic) IBOutlet UITextField *nombreTextField;
@property (strong, nonatomic) IBOutlet UITextField *apellidoPatTextField;
@property (strong, nonatomic) IBOutlet UITextField *apellidoMatTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *telefonoTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmaPassTextField;
@property (strong,nonatomic) IBOutlet UIScrollView *registroScrollView;
@property (nonatomic, assign) UITextField *activeTextField;



@end
