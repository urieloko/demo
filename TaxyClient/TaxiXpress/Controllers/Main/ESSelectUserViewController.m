//
//  ESSelectUserViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESSelectUserViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "Reachability.h"

@interface ESSelectUserViewController ()

@property (nonatomic,strong) UIBarButtonItem *menuBtn;
extern UIApplication* UIApp;
@end

@implementation ESSelectUserViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}
-(void)viewDidLoad{
    
    [self loadViewController];
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self checkForWIFIConnection];
    }
    
- (void)checkForWIFIConnection {
        Reachability* wifiReach = [Reachability reachabilityForInternetConnection];
        NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
        if ((netStatus != ReachableViaWWAN) && (netStatus != ReachableViaWiFi))
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No hay conexion a Internet", @"AlertView")
                                                                message:NSLocalizedString(@"Esta Aplicación requiere internet. Activa datos o wifi", @"AlertView")
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil)
                                                      otherButtonTitles:nil,nil];
             alertView.tag = 01;
            [alertView show];
        }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{   if (alertView.tag == 01){
    if(buttonIndex==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
      //  [[UIApplication sharedApplication] launchApplicationWithIdentifier:@"com.apple.mobilesafari" suspended:NO];
    }
}
}

//    _menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btnMenu"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];

    
    
    
//    _menuBtn.tintColor = [UIColor clearColor];
    
//    [UINavigationBar appearance] setbac
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"botonRegreso.png"]];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"botonRegreso.png"]];
    
//    UIImage * menuImage = nil;
//    UIButton * menuBtn = nil;
//    
//    // Setting NavigationBar
//    menuImage = [UIImage imageNamed:@"btnMenu"];
//    menuBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, menuImage.size.width, menuImage.size.height)];
//    [menuBtn setImage:menuImage forState:UIControlStateNormal];
//    [menuBtn setImage:menuImage forState:UIControlStateHighlighted];
//    
//    [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
//    _menuBtn =[[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    
//    self.navigationItem.leftBarButtonItem = _menuBtn;


@end
