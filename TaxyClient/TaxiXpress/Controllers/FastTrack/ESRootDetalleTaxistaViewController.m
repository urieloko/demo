//
//  ESRootDetalleTaxistaViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 09/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESRootDetalleTaxistaViewController.h"
#import "ESTabBarView.h"



@interface ESRootDetalleTaxistaViewController ()
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic,strong) ESDetalleTaxistaViewController *infoVC;
@property (nonatomic,strong) ESMasDetalleTaxistaViewController *vermasVC;
@property (nonatomic,strong) UIView *infoView;
@property (nonatomic,strong) UIView *vermasView;
@property (nonatomic,strong) ESTabBarView *tabBarView;

@property (nonatomic,strong) NSLayoutConstraint *infoWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *infoHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *infoHCenterConstraint;
@property (nonatomic,strong) NSLayoutConstraint *infoVCenterConstraint;

@property (nonatomic,strong) NSLayoutConstraint *vermasWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *vermasHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *vermasHCenterConstraint;
@property (nonatomic,strong) NSLayoutConstraint *vermasVCenterConstraint;

-(void)setUpView;
-(void)loadViewControllers;

-(void)setTabInfoViewController:(ESDetalleTaxistaViewController *)infoVC;
-(void)setTabVermasViewController:(ESMasDetalleTaxistaViewController *)vermasVC;
-(void)setContraintsToInfoView:(UIView *)view;
-(void)setContraintsToVermasView:(UIView *)view;

-(void)showInfoView;
-(void)showVermasView;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end

@implementation ESRootDetalleTaxistaViewController

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
    [self loadViewController];
    [self  addBackButton];
    [self loadViewControllers];
    [self setUpView];
    // Do any additional setup after loading the view.
}
-(void)setUpView {
    
    [self loadBackgroundImage];
    
    // Colocar Tab en el NavigationBar
    _tabBarView = [[ESTabBarView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)
                                           leftTitle:NSLocalizedString(LBL_DETAIL, nil)
                                         leftHandler:^(){
                                             [self showInfoView];
                                         }
                                          rightTitle:NSLocalizedString(LBL_SHOWMORE, nil)
                                          rightBlock:^(){
                                              [self showVermasView];
                                          }];
    
    [self addTitleView:_tabBarView];
}

-(void)loadViewControllers
{
    if (self.storyboard) {
        
        // Cargar el controlador de Mas detalle de Taxista
        @try {
            [self performSegueWithIdentifier:SG_ID_VERMAS sender:nil];
        }
        @catch (NSException *exception) {}
        
        // Cargar el controlador del detalle de taxista
        @try {
            [self performSegueWithIdentifier:SG_ID_INFO sender:nil];
        }
        @catch (NSException *exception) {}
    }
}
-(void)setTabInfoViewController:(ESDetalleTaxistaViewController *)infoVC
{
    [self addChildViewController:infoVC];
    [self setContraintsToInfoView:infoVC.view];
    [infoVC didMoveToParentViewController:self];
}
-(void)setTabVermasViewController:(ESMasDetalleTaxistaViewController *)vermasVC
{
    [self addChildViewController:vermasVC];
    [self setContraintsToInfoView:vermasVC.view];
    [vermasVC didMoveToParentViewController:self];
}

-(void)setContraintsToInfoView:(UIView *)view
{
    _infoView = view;
    
    [_infoView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_contentView addSubview:_infoView];

    _infoWidthConstraint = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    _infoHeightConstraint = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    _infoHCenterConstraint = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    _infoVCenterConstraint = [NSLayoutConstraint constraintWithItem:_infoView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [_contentView addConstraint:_infoWidthConstraint];
    [_contentView addConstraint:_infoHeightConstraint];
    [_contentView addConstraint:_infoHCenterConstraint];
    [_contentView addConstraint:_infoVCenterConstraint];

}

-(void)setContraintsToVermasView:(UIView *)view
{
    _vermasView = view;
    
    [_vermasView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_contentView addSubview:_vermasView];
    
    _vermasWidthConstraint = [NSLayoutConstraint constraintWithItem:_vermasView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    _vermasHeightConstraint = [NSLayoutConstraint constraintWithItem:_vermasView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    _vermasHCenterConstraint = [NSLayoutConstraint constraintWithItem:_vermasView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    _vermasVCenterConstraint = [NSLayoutConstraint constraintWithItem:_vermasView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [_contentView addConstraint:_vermasWidthConstraint];
    [_contentView addConstraint:_vermasHeightConstraint];
    [_contentView addConstraint:_vermasHCenterConstraint];
    [_contentView addConstraint:_vermasVCenterConstraint];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ESRootTaxiRequestDelegate Methods

-(void)showInfoView {
    _infoView.hidden = NO;
}

-(void)showVermasView {
    _infoView.hidden =YES;
}
#pragma mark - Storyboard Methods

-(void)prepareForSegue:(ESDetalleTaxistaSegue *)segue sender:(id)sender {
    NSString *identifier = segue.identifier;
   UIViewController *vc = segue.destinationViewController;
    if ([identifier isEqualToString:SG_ID_INFO]) {
       
        segue.performBlock = ^( ESDetalleTaxistaSegue* segue, UIViewController* tabVC)
        {
            ((ESDetalleTaxistaViewController *)tabVC).taxista = _taxista;
            ((ESDetalleTaxistaViewController *)tabVC).clienteMarker =_clienteMarker;
            [self setTabInfoViewController:(ESDetalleTaxistaViewController *)tabVC];
        };
    } else if ([identifier isEqualToString:SG_ID_VERMAS]) {
        
        
        
        
        segue.performBlock = ^( ESDetalleTaxistaSegue* segue, UIViewController* tabVC)
        {
            ((ESMasDetalleTaxistaViewController *)tabVC).taxista = _taxista;
            [self setTabVermasViewController:(ESMasDetalleTaxistaViewController *)tabVC];
        };
    }
}

@end
