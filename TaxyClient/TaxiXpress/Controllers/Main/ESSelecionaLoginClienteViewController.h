//
//  ESSelecionaLoginClienteViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 30/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GPPSignIn.h"
#import "ESLocalizableConstants.h"

@interface ESSelecionaLoginClienteViewController : UIViewController <GPPSignInDelegate>
- (void)checkForWIFIConnection;
- (IBAction)buttonTouched:(id)sender;
- (IBAction)loginWithGooglePlus:(id)sender;
-(IBAction)regresoAyudaMenu:(UIStoryboardSegue *)segue;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *user;
@property (strong,nonatomic) IBOutlet UIButton *loginbtn;
@property (strong,nonatomic) IBOutlet UIButton *registerBtn;
@property (strong,nonatomic) IBOutlet UIButton *logFbBtn;
@property (strong,nonatomic) IBOutlet UIButton *logGpBtn;
@property (strong,nonatomic) IBOutlet UILabel *userLog;
@property (strong,nonatomic) IBOutlet UILabel *userOR;
-(IBAction) iniciaSessionButton: (id)sender;
@end
