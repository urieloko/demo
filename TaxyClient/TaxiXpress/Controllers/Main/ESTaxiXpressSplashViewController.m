//
//  ESTaxiXpressSplashViewController.m
//  TaxiXpress
//
//  Created by Roy on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESTaxiXpressSplashViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ESTaxiXpressSplashViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *splashImage;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleSplash;
@property (strong, nonatomic) IBOutlet UIButton *btnInicia;
@property (strong, nonatomic) IBOutlet UIImageView *splashTaxy;
@property (strong, nonatomic) IBOutlet UILabel *lblCrearCuenta;
@property (strong, nonatomic) IBOutlet UILabel *lblcondiciones;
@property (strong, nonatomic) IBOutlet UILabel *lblpoliticas;
@property (strong, nonatomic) IBOutlet UILabel *lblDerechosRes;

-(void) setupView;
@end

@implementation ESTaxiXpressSplashViewController

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
    [super viewDidLoad];
    [self loadBackgroundImage];
    [self setupView];
    /*
    
    if([UIScreen mainScreen].bounds.size.height > 500)
    {
        //la resolucion es de 4in
       _splashImage.image=[UIImage imageNamed:@"splash40.png"];
    }
    else
    {
        //la resolucion es de 3.5in
        _splashImage.image=[UIImage imageNamed:@"splash35.png"];
    }
 
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(goToNextViewController) userInfo:nil repeats:NO];
    */
    
}
-(void) setupView {
    [_btnInicia setTitle:NSLocalizedString(BTN_INICIA, nil) forState:UIControlStateNormal];
    _lblTitleSplash.text = NSLocalizedString(LBL_WELCOME, nil);
    _splashTaxy.image = [UIImage imageNamed:@"taxyLogo"];
    _lblDerechosRes.text = NSLocalizedString(LBL_ABOUT, nil);
    _lblCrearCuenta.text = NSLocalizedString(@"Al crear tu cuenta,", nil);
    _lblcondiciones.text = [NSString stringWithFormat:NSLocalizedString(@"aceptas las ", nil),@"condiciones de servicio"];
    
}


- (void) goToNextViewController {
    [self performSegueWithIdentifier:@"SplashToUserIdSegue" sender:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Status Bar Methods
- (BOOL)prefersStatusBarHidden
{
    return YES;
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

- (IBAction)startBtn:(id)sender {
    [self goToNextViewController];
}
@end
