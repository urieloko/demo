//
//  ESSelecionaLoginClienteViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 30/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESSelecionaLoginClienteViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "Reachability.h"
#import "ESAppDelegate.h"
#import "ESStoryboardConstants.h"
#import "ESSettingsConstants.h"

#import "GTLPlusConstants.h"




@interface ESSelecionaLoginClienteViewController ()
@property (nonatomic,strong) UIBarButtonItem *menuBtn;
extern UIApplication* UIApp;
@property (nonatomic,strong) GTMOAuth2Authentication *auth;
-(IBAction)hidekeyboard:(id)sender;
-(void)setUpView;
@end

@implementation ESSelecionaLoginClienteViewController
-(IBAction)hidekeyboard:(id)sender{
    [_password resignFirstResponder];
    [_user resignFirstResponder];
}

- (IBAction)loginWithGooglePlus:(id)sender{

        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        [signIn authenticate];


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self loadBackgroundImage ];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self checkForWIFIConnection];
    [self setUpView];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:KEY_FB_LOGIN]) {
        [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
    }
    
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    
    signIn.clientID = GP_CLIENT_ID;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin, // definido en GTLPlusConstants.h
                     nil];
    signIn.delegate = self;
    [signIn trySilentAuthentication];
    [self refreshInterfaceBasedOnSignIn];
    
}
-(void)setUpView {
    NSString *loginstr = NSLocalizedString(BTN_HOME_LOGIN, nil);
    _password.placeholder = NSLocalizedString(LBL_HOME_PASS, nil);
    _user.placeholder = NSLocalizedString(LBL_HOME_USER, nil);
    _userLog.text = NSLocalizedString(LBL_TITLE_SIGNIN, nil);
    _userOR.text = NSLocalizedString(LBL_TITLE_SIGNOR, nil);
    [_loginbtn setTitle:loginstr forState:UIControlStateNormal];
    [_loginbtn setTitle:loginstr forState:UIControlStateDisabled];
    [_loginbtn setTitle:loginstr forState:UIControlStateHighlighted];
    [_loginbtn setTitle:loginstr forState:UIControlStateSelected];
    [_loginbtn setTitle:loginstr forState:UIControlStateReserved];
    [_loginbtn setTitle:loginstr forState:UIControlStateApplication];
    [_registerBtn setTitle:NSLocalizedString(BTN_HOME_REGISTER, nil) forState:UIControlStateNormal];
    [_logFbBtn setTitle:NSLocalizedString(BTN_HOME_LOGINFG, nil) forState:UIControlStateNormal];
    [_logGpBtn setTitle:NSLocalizedString(BTN_HOME_LOGINFG, nil) forState:UIControlStateNormal];
    
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
-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
        // Perform other actions here, such as showing a sign-out button
    }
}
- (IBAction)buttonTouched:(id)sender
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey: KEY_FB_LOGIN];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
             ESAppDelegate* appDelegate = (ESAppDelegate*)([UIApplication sharedApplication].delegate);
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             //[appDelegate sessionStateChanged:session state:state error:error];
             [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
         }];
    }
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{   if (alertView.tag == 01){
    if(buttonIndex==1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
        //[[UIApplication sharedApplication] launchApplicationWithIdentifier:@"com.apple.mobilesafari" suspended:NO];
    }
}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GooglePlus Methods

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error{
    NSLog(@"logueado google");
    _auth = auth;
    if (!error) {
        [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
        [self refreshInterfaceBasedOnSignIn];
    }
}
-(IBAction)regresoAyudaMenu:(UIStoryboardSegue *)segue{
    [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
}
-(IBAction) iniciaSessionButton: (id)sender{

    UIAlertView *alert = nil;
    if (_user.text && _user.text.length == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Hey" message:NSLocalizedString(LBL_CHECK_USER, nil) delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert show];
    }else if (_password.text && _password.text.length == 0){
        alert = [[UIAlertView alloc] initWithTitle:@"Hey" message:NSLocalizedString(LBL_CHECK_PASSWORD, nil) delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert show];
    }else{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:KEY_FB_LOGIN];
        [self performSegueWithIdentifier:SG_ID_FACEBOOK_LOGIN_TO_MAP_CLIENT sender:self];
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
