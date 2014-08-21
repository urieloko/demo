//
//  ESMapClientViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESMapClientViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ESTaxistaBusiness.h"
#import "ESListaTaxisViewController.h"
#import "ESDetalleTaxistaViewController.h"
#import "ESSitiosCercanosViewController.h"
#import "SVProgressHUD.h"
#import "ESUtils.h"

#define kIdTaxistaKey @"idTaxista"
#define kTaxistaMarkerKey @"taxistaMarker"

@interface ESMapClientViewController () <GMSMapViewDelegate,CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic,strong) GMSMarker *sourceMarker;
@property(nonatomic,strong) GMSMarker *destinationMarker;
@property(nonatomic,strong) NSArray *address;
@property BOOL destination;

@property (strong, nonatomic) IBOutlet UISearchBar *addressSearchBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *tripSegmented;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property (strong, nonatomic) ESTaxistaBusiness *taxistaBusiness;
@property (strong,nonatomic) ESClienteBusiness *clienteBusiness;
@property (strong, nonatomic) NSMutableArray *taxiMarker;
@property (nonatomic,strong) ESTaxistaBusiness *taxistaBussiness;
@property(nonatomic,strong) GMSMarker *clienteMarker;
- (IBAction)verTaxisDisponibles:(id)sender;

- (IBAction)changeTripMarker:(id)sender;
-(void)showFourSquareScene;

@end

@implementation ESMapClientViewController
@synthesize mapView;
@synthesize locationManager;

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
    [self addFourSquareItemButtonWithSelector:@selector(showFourSquareScene)];
    
    _address = @[@"Camino Unión 100",@"Paseo de la Reforma 222"];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    
    if([CLLocationManager locationServicesEnabled]){
        locationManager.delegate = self;
        
        
        [locationManager startUpdatingLocation];
        
    }
    
    if (!_taxistaBusiness) {
        _taxistaBusiness = [[ESTaxistaBusiness alloc] init];
    }
    
    if (!_clienteBusiness) {
        _clienteBusiness = [ESClienteBusiness new];
    }
    
}
-(IBAction)origenButton:(id)sender{
    CLLocation *location = mapView.myLocation;
    if (location) {
        [mapView animateToLocation:location.coordinate];}
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    static BOOL fistTime = YES;
    GMSCameraPosition *camera = nil;
    CGFloat latitud = 0.0f;
    CGFloat longitud = 0.0f;
    ESUbicacion *posUsuario = nil;
    
    if (fistTime) {
        latitud = newLocation.coordinate.latitude;
        longitud = newLocation.coordinate.longitude;
        camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:15];
        
        mapView.myLocationEnabled = YES;
        mapView.camera = camera;
        mapView.delegate = self;
        
        _sourceMarker = [[GMSMarker alloc] init];
        _sourceMarker.position = CLLocationCoordinate2DMake(latitud,longitud);
        
        _sourceMarker.title = @"Origen";
        _sourceMarker.snippet = @"Source";
        _sourceMarker.icon = [UIImage imageNamed:@"iconUbica"];
        _sourceMarker.map = mapView;

#warning Código para colocar el destino en el mapa
//        _destinationMarker = [[GMSMarker alloc] init];
//        _destinationMarker.position = CLLocationCoordinate2DMake(latitud,longitud+0.002);
//        
//        _destinationMarker.title = @"Destino";
//        _destinationMarker.snippet = @"Destination";
//        _destinationMarker.icon = [UIImage imageNamed:@"iconUbica"];
//        _destinationMarker.map = mapView;
        
        fistTime = NO;
        
        // Petición de taxistas
        if (!_taxistaBusiness) {
            _taxistaBusiness = [[ESTaxistaBusiness alloc] init];
        }
        
        posUsuario = [ESUbicacion new];
        
        posUsuario.latitud = latitud;
        posUsuario.longitud = longitud;
        
        [_taxistaBusiness posicionTaxisCercanos:posUsuario completionHandler:^(NSArray *posicionTaxi) {
            
            //Crear markers de los taxis
            _taxiMarker = [NSMutableArray array];
            
            for (ESUbicacion *posTaxi in posicionTaxi) {
                GMSMarker *taxiMarker = nil;
                
                taxiMarker = [[GMSMarker alloc] init];
                taxiMarker.position = CLLocationCoordinate2DMake(posTaxi.latitud,posTaxi.longitud);
                
                taxiMarker.icon = [UIImage imageNamed:@"taxiUbica"];
                taxiMarker.map = mapView;
                
                [_taxiMarker addObject:@{kIdTaxistaKey: posTaxi,kTaxistaMarkerKey: taxiMarker}];
            }
            
        } errorHandler:nil];
    }
    
    // Si solo lo necesitamos una vez podemos dejar de actualizar las coordenadas aunque el usuario se mueva.
    
    // [self.locationManager stopUpdatingLocation];
    
    // Si necesitamos una precisión bastante buena, dejaremos unos segundos para que siga actualizando antes de pararlo, ya que la primera vez suele devolver la última posición recogida, por el iOS o por cualquier otra aplicación.
    
    // Si no lo paramos, el método será llamado en función de la precisión establecida cada X metros.
}



#pragma mark - GMSMapViewDelegate Methods

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
    if (_destination) {
        _destinationMarker.position = CLLocationCoordinate2DMake(position.target.latitude,position.target.longitude);
    } else {
        _sourceMarker.position = CLLocationCoordinate2DMake(position.target.latitude,position.target.longitude);
    }
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    
    NSLog(@"DidTapMarker");
    
    for (NSDictionary *taxiItem in _taxiMarker) {
        if (taxiItem[kTaxistaMarkerKey] == marker) {
#warning Lanzar petición para recuperar los datos del taxi seleccionado y darlos a la siguiente pantalla
            [ESUtils showProgressWithBackgroundColor:[ESUtils colorFromRGB:0xd8b156] foregroundColor:[UIColor blackColor] status:NSLocalizedString(LBL_PROGRESS, nil) maskType:SVProgressHUDMaskTypeGradient];
            [_taxistaBusiness infoTaxista:taxiItem[kIdTaxistaKey] completionHandler:^(ESTaxista *taxista) {
                _taxista = taxista;
                
                [SVProgressHUD dismiss];
                [self performSegueWithIdentifier:SG_ID_MAP_CLIENT_TO_DETALLE_TAXI sender:self];
            } errorHandler:nil];
            
            return YES;
        }
    }
    
    return NO;
}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _address.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _address[indexPath.row];
    
    return cell;
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

- (IBAction)verTaxisDisponibles:(id)sender {
    
    CLLocationCoordinate2D posicion = _clienteMarker.position;
    
    _taxistaBussiness = [ESTaxistaBusiness new];
    [ESUtils showProgressWithBackgroundColor:[ESUtils colorFromRGB:0xd8b156] foregroundColor:[UIColor blackColor] status:NSLocalizedString(LBL_PROGRESS, nil) maskType:SVProgressHUDMaskTypeGradient];
    
    [_taxistaBussiness taxisCercanos:[[ESUbicacion alloc] initWithCoordinate2D:posicion] completionHandler:^(NSArray *taxista){
        _taxistas = taxista;
        [SVProgressHUD dismiss];
        [self performSegueWithIdentifier:SG_ID_MAP_CLIENT_TO_LISTA_TAXI sender:self];
    } errorHandler:nil];
    
}

- (IBAction)changeTripMarker:(id)sender {
    GMSCameraPosition *newCamera = nil;
    GMSCameraPosition *oldCamera = nil;
    
    CLLocationDegrees latitud = 0.0;
    CLLocationDegrees longitud = 0.0;
    
    switch (_tripSegmented.selectedSegmentIndex) {
        case 0:
            _destination = NO;
            latitud = _sourceMarker.position.latitude;
            longitud = _sourceMarker.position.longitude;
            break;
            
        case 1:
            _destination = YES;
            latitud = _destinationMarker.position.latitude;
            longitud = _destinationMarker.position.longitude;
            break;
    }
    
    oldCamera = mapView.camera;
    newCamera = [GMSCameraPosition cameraWithLatitude:latitud longitude:longitud zoom:oldCamera.zoom];
    
    mapView.camera = newCamera;
}

#pragma mark - Storyboard Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *vc = segue.destinationViewController;
    GMSMarker *clienteMarker = nil;
    CLLocationCoordinate2D posicion = _sourceMarker.position;

    if ([segue.identifier isEqualToString:SG_ID_MAP_CLIENT_TO_LISTA_TAXI] | [segue.identifier isEqualToString:SG_ID_MAP_CLIENT_TO_DETALLE_TAXI]) {
        clienteMarker = [[GMSMarker alloc] init];
        clienteMarker.position = CLLocationCoordinate2DMake(posicion.latitude,posicion.longitude);
        clienteMarker.title = @"Origen";
        clienteMarker.snippet = @"Source";
        clienteMarker.icon = [UIImage imageNamed:@"iconUbica"];
        
        if ([segue.identifier isEqualToString:SG_ID_MAP_CLIENT_TO_LISTA_TAXI]) {
            ((ESListaTaxisViewController *)vc).clienteMarker = clienteMarker;
            ((ESListaTaxisViewController *)vc).taxista = _taxistas;
        } else {
            ((ESDetalleTaxistaViewController *)vc).taxista = _taxista;
            ((ESDetalleTaxistaViewController *)vc).clienteMarker =clienteMarker;
        }
        
    } else if ([segue.identifier isEqualToString:SG_ID_MAP_CLIENT_TO_SITIOS_CERCANOS]) {
        ((ESSitiosCercanosViewController *)vc).venue = _venues;
    }
}


-(void)showFourSquareScene {
    CLLocationCoordinate2D posicion = _sourceMarker.position;
    ESSearchVenues *searchVenues = [[ESSearchVenues alloc]initWithCoordinate:posicion];
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:@"Uuups" message:@"No se encontraron luegares cercanos" delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
    [ESUtils showProgressWithBackgroundColor:[ESUtils colorFromRGB:0xd8b156] foregroundColor:[UIColor blackColor] status:NSLocalizedString(LBL_PROGRESS, nil) maskType:SVProgressHUDMaskTypeGradient];
    [_clienteBusiness lugaresCercanos:searchVenues completionHandler:^(NSArray *venue){
        _venues = venue;
        [SVProgressHUD dismiss];
        
        if (_venues.count > 0) {
            [self performSegueWithIdentifier:SG_ID_MAP_CLIENT_TO_SITIOS_CERCANOS sender:self];
        } else {
            [alert show];
        }
        
    } errorHandler:^(NSError * error){
        alert.message = @"Ocurrio un error, favor de intentar más tarder";
        
        [alert show];
    }];
}

@end
