//
//  ESRootTaxiRequestViewController.m
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESRootTaxiRequestViewController.h"
#import "ESMapTaxiRequestViewController.h"
#import "ESPlaceTaxiRequestViewController.h"
#import "ESTaxiRequestSegue.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESUtils.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "SVProgressHUD.h"
#import "ESListaTaxisViewController.h"
#import "ESSnippetView.h"
#import "ESTabBarView.h"

@interface ESRootTaxiRequestViewController ()

//@property (strong, nonatomic) IBOutlet UIButton *mapTabButton;
//@property (strong, nonatomic) IBOutlet UIButton *placesTabButton;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic,strong) ESMapTaxiRequestViewController *mapVC;
@property (nonatomic,strong) ESPlaceTaxiRequestViewController *placeVC;
@property (nonatomic,strong) UIView *mapView;
@property (nonatomic,strong) UIView *placeView;
@property (nonatomic,strong) ESTabBarView *tabBarView;
@property BOOL menuVisible;


@property (nonatomic,strong) NSLayoutConstraint *mapWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *mapHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *mapHCenterConstraint;
@property (nonatomic,strong) NSLayoutConstraint *mapVCenterConstraint;

@property (nonatomic,strong) NSLayoutConstraint *placeWidthConstraint;
@property (nonatomic,strong) NSLayoutConstraint *placeHeightConstraint;
@property (nonatomic,strong) NSLayoutConstraint *placeHCenterConstraint;
@property (nonatomic,strong) NSLayoutConstraint *placeVCenterConstraint;

@property (nonatomic,strong) ESTaxistaBusiness *taxistaBusiness;

-(void)setUpView;
-(void)loadViewControllers;

-(void)setTabMapViewController:(ESMapTaxiRequestViewController *)mapVC;
-(void)setTabPlaceViewController:(ESPlaceTaxiRequestViewController *)placeVC;
-(void)setContraintsToMapView:(UIView *)view;
-(void)setContraintsToPlaceView:(UIView *)view;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end

@implementation ESRootTaxiRequestViewController

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
    [self setUpView];
}

-(void)setUpView
{
    [self loadBackgroundImage];
    [self addAboutButton];
    [self addMenuButtonWithSelector:@selector(manageProgressView)];
    
    // Colocar Tab en el NavigationBar
    _tabBarView = [[ESTabBarView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)
                                           leftTitle:NSLocalizedString(BTN_TAB_MAP, nil)
                                         leftHandler:^(){
                                             [self showMapView];
                                         }
                                          rightTitle:NSLocalizedString(BTN_TAB_SITES, nil)
                                          rightBlock:^(){
                                              [self showPlaceView];
                                          }];
    
    [self addTitleView:_tabBarView];
    
    [self loadViewControllers];
}

-(void)loadViewControllers
{
    if (self.storyboard) {
        
        // Cargar el controlador de los lugares (Foursquare)
        @try {
            [self performSegueWithIdentifier:SG_ID_PLACE sender:nil];
        }
        @catch (NSException *exception) {}
        
        // Cargar el controlador del mapa
        @try {
            [self performSegueWithIdentifier:SG_ID_MAP sender:nil];
        }
        @catch (NSException *exception) {}
    }
}

-(void)setTabMapViewController:(ESMapTaxiRequestViewController *)mapVC
{
    _mapVC = mapVC;
    
    _mapVC.delegate = self;
    
    [self addChildViewController:mapVC];
    [self setContraintsToMapView:mapVC.view];
    [mapVC didMoveToParentViewController:self];
}

-(void)setTabPlaceViewController:(ESPlaceTaxiRequestViewController *)placeVC
{
    _placeVC = placeVC;
    
    _placeVC.delegate = self;
    
    [self addChildViewController:placeVC];
    [self setContraintsToMapView:placeVC.view];
    [placeVC didMoveToParentViewController:self];
}

-(void)setContraintsToMapView:(UIView *)view
{
    _mapView = view;
    
    [_mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_contentView addSubview:_mapView];
    
    _mapWidthConstraint = [NSLayoutConstraint constraintWithItem:_mapView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    _mapHeightConstraint = [NSLayoutConstraint constraintWithItem:_mapView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    _mapHCenterConstraint = [NSLayoutConstraint constraintWithItem:_mapView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    _mapVCenterConstraint = [NSLayoutConstraint constraintWithItem:_mapView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [_contentView addConstraint:_mapWidthConstraint];
    [_contentView addConstraint:_mapHeightConstraint];
    [_contentView addConstraint:_mapHCenterConstraint];
    [_contentView addConstraint:_mapVCenterConstraint];
}

-(void)setContraintsToPlaceView:(UIView *)view
{
    _placeView = view;
    
    [_placeView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_contentView addSubview:_placeView];
    
    _placeWidthConstraint = [NSLayoutConstraint constraintWithItem:_placeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    _placeHeightConstraint = [NSLayoutConstraint constraintWithItem:_placeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    _placeHCenterConstraint = [NSLayoutConstraint constraintWithItem:_placeView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    _placeVCenterConstraint = [NSLayoutConstraint constraintWithItem:_placeView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    [_contentView addConstraint:_placeWidthConstraint];
    [_contentView addConstraint:_placeHeightConstraint];
    [_contentView addConstraint:_placeHCenterConstraint];
    [_contentView addConstraint:_placeVCenterConstraint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ESRootTaxiRequestDelegate Methods

-(void)manageProgressView
{
    _menuVisible = !_menuVisible;
    
    if ([_placeVC.foursquareBusiness isRunningNearbyLocation]) {
//    if (_placeVC.placesTask && _placeVC.placesTask.state == NSURLSessionTaskStateRunning) {
        if (_menuVisible) {
            [_placeVC hideProgress];
        } else {
            [_placeVC showProgress];
        }
    } else {
        [_placeVC hideProgress];
    }
}

-(void)showMapView
{    
    _mapView.hidden = NO;
    
    [_placeVC cancelRequestPlaces];
}

-(void)showPlaceView
{
    GMSMarker *oldMeettingPoint = nil;
    GMSMarker *meettingPoint = nil;
    CLLocationCoordinate2D posicion = CLLocationCoordinate2DMake(0, 0);
    ESSearchVenues *searchVenues = [[ESSearchVenues alloc]initWithCoordinate:posicion];
    
    _mapView.hidden =YES;
    oldMeettingPoint = _mapVC.oldMeetingPoint;
    meettingPoint = _mapVC.meetingPoint;
    
    if (meettingPoint && ((!oldMeettingPoint && !_placeVC.venue) || (oldMeettingPoint  && (oldMeettingPoint.position.latitude != meettingPoint.position.latitude || oldMeettingPoint.position.longitude != meettingPoint.position.longitude))) ) {
        
        [_placeVC cleanPlaces];
        posicion = meettingPoint.position;
        searchVenues = [[ESSearchVenues alloc]initWithCoordinate:posicion];
        [_placeVC requestPlacesWithSearchVenue:searchVenues];
    }
}

-(void)lookAvailableDrivers
{
    CLLocationCoordinate2D posicion = _mapVC.meetingPoint.position;
    
    _taxistaBusiness = [ESTaxistaBusiness new];
    
    [ESUtils showProgressWithBackgroundColor:[ESUtils colorFromRGB:0xd8b156] foregroundColor:[UIColor blackColor] status:NSLocalizedString(LBL_PROGRESS, nil) maskType:SVProgressHUDMaskTypeGradient];
    
    [_taxistaBusiness taxisCercanos:[[ESUbicacion alloc] initWithCoordinate2D:posicion] completionHandler:^(NSArray *taxista){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ESFastTrack" bundle:nil];
        ESListaTaxisViewController *listaTaxisVC = [storyboard instantiateViewControllerWithIdentifier:SB_ID_LISTA_TAXIS];
        
        listaTaxisVC.taxista = taxista;
        [SVProgressHUD dismiss];
        [self.navigationController pushViewController:listaTaxisVC animated:YES];
//        [self performSegueWithIdentifier:SG_ID_MAP_CLIENT_TO_LISTA_TAXI sender:self];
    } errorHandler:nil];
}

-(void)updateOldMeetingPoint
{
    if (_mapVC.oldMeetingPoint) {
        _mapVC.oldMeetingPoint = [[GMSMarker alloc] init];
        _mapVC.oldMeetingPoint.position = CLLocationCoordinate2DMake(_mapVC.meetingPoint.position.latitude,_mapVC.meetingPoint.position.longitude);
    }
}

-(void)updateMeetingPointWithPlace {
    GMSCameraPosition *camera = nil;
    ESVenue *venueSelected = _placeVC.venueSelected;
    ESUbicacion *ubicacion = venueSelected.location;
    
    if (venueSelected && ubicacion) {
        _mapVC.venueSelected = venueSelected;
     
        [_tabBarView tapLeftTabButton];
        
        camera = [GMSCameraPosition cameraWithLatitude:ubicacion.latitud longitude: ubicacion.longitud zoom:_mapVC.currentCamera.zoom];
        _mapVC.mapView.camera = camera;
        _mapVC.currentCamera = camera;
    }
}

#pragma mark - Storyboard Methods

-(void)prepareForSegue:(ESTaxiRequestSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:SG_ID_MAP]) {
        segue.performBlock = ^( ESTaxiRequestSegue* segue, UIViewController* tabVC)
        {
            [self setTabMapViewController:(ESMapTaxiRequestViewController *)tabVC];
        };
    } else if ([identifier isEqualToString:SG_ID_PLACE]) {
        segue.performBlock = ^( ESTaxiRequestSegue* segue, UIViewController* tabVC)
        {
            [self setTabPlaceViewController:(ESPlaceTaxiRequestViewController *)tabVC];
        };
    }
}
-(IBAction)regresoRegistroCliente:(UIStoryboardSegue *)segue {
    NSLog(@"regresa cliente");
    NSString *mensaje = NSLocalizedString(@"Bienvenido a Taxy.", nil);
    UIAlertView *alert = nil;
 
        alert = [[UIAlertView alloc] initWithTitle:@"Gracias" message:mensaje delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert show];


}

-(IBAction)regresoSitiosCercanos:(UIStoryboardSegue *)segue {
    NSLog(@"regresa cliente");
    

}

-(IBAction)regresoDetalleTaxista:(UIStoryboardSegue *)segue {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", nil) message:@"La solicitud fue rechazada" delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
    
    [alert show];
}

-(IBAction)regresoRespuestaTaxistaSolicitud:(UIStoryboardSegue*)segue {
    NSLog(@"Cancelo Solicitud cliente");
    NSString *mensaje = @"La solicitud ha sido cancelada";
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", nil) message:mensaje delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil, nil];
    alert.delegate = self;
    [alert show];
}
-(IBAction)regresoCancelaSolicitud:(UIStoryboardSegue*)segue {
    
}
-(IBAction)regresoEnviaComentario:(UIStoryboardSegue*)segue {
    
}

@end
