//
//  ESMapTaxiRequestViewController.m
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESMapTaxiRequestViewController.h"
#import "ESUtils.h"
#import "ESSettingsConstants.h"
#import "SVProgressHUD.h"
#import "ESSnippetView.h"

#define kIdTaxistaKey @"idTaxista"
#define kTaxistaMarkerKey @"taxistaMarker"

@interface ESMapTaxiRequestViewController ()
@property (strong, nonatomic) IBOutlet UIButton *locationCurrentButton;
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *availableTaxisButton;

@property(nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *taxiMarkerDetail;
@property(nonatomic,strong) GMSMarker *markerSelected;
@property(nonatomic,strong) ESTaxista *driverSelected;

-(void)setUpLocation;
-(void)setUpView;
- (IBAction)lookAvailableDrivers:(id)sender;
- (IBAction)editAddress:(id)sender;
- (IBAction)setCurrentLocation:(id)sender;

@end

@implementation ESMapTaxiRequestViewController

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
    
    [self setUpLocation];
    [self setUpView];
}

-(void)setUpLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    
    
    if([CLLocationManager locationServicesEnabled]){
        _locationManager.delegate = self;
        [_locationManager startUpdatingLocation];
    }
}

-(void)setUpView
{
    UIFont *font = [ESUtils fontTrebuchetMsWithSize:SIZE_DEFAULT];
    
    [ESUtils setUpLabel:_addressLbl text:NSLocalizedString(LBL_FIND_ADDRESS, nil) font:font color:[UIColor whiteColor]];
    
    [ESUtils setUpView:_availableTaxisButton cornerRadius:CORNER_RADIOUS backgroundColor:[ESUtils colorFromRGB:COLOR_BUTTON_MAP_ENABLED]];
    [ESUtils setUpButton:_availableTaxisButton colorTitle:[ESUtils colorFromRGB:COLOR_TITLE_BUTTON_MAP] title:NSLocalizedString(BTN_AVAILABLE_TAXI, nil) forState:UIControlStateNormal];
    [ESUtils setUpButton:_availableTaxisButton colorTitle:[UIColor blackColor] title:NSLocalizedString(BTN_SEARCH_TAXI, nil) forState:UIControlStateDisabled];
    _availableTaxisButton.titleLabel.font = font;
    _availableTaxisButton.enabled = NO;
}

- (IBAction)lookAvailableDrivers:(id)sender {
    [_delegate lookAvailableDrivers];
}

- (IBAction)editAddress:(id)sender {
    UIAlertView *alert = [ESUtils generateInputAlertViewWithTitle:[_currentAddress getStreetNumberFormatOfAddress] message:NSLocalizedString(@"Ingresa un número específico", nil) keyboardType:UIKeyboardTypeDefault alertDelegate:self tag:0 textFieldDelegate:self];
    
    [alert show];
}

- (IBAction)setCurrentLocation:(id)sender {
//    [_locationManager startUpdatingLocation];
    CLLocation *location = _mapView.myLocation;
    if (location) {
        [_mapView animateToLocation:location.coordinate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    CGFloat latitud = 0.0f;
    CGFloat longitud = 0.0f;

    latitud = newLocation.coordinate.latitude;
    longitud = newLocation.coordinate.longitude;
    _currentCamera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:_currentCamera ? _currentCamera.zoom: CAMERA_ZOOM_DEFAULT];
    
    _mapView.myLocationEnabled = YES;
    _mapView.camera = _currentCamera;
    _mapView.delegate = self;
    
    _meetingPoint = _meetingPoint? _meetingPoint : [[GMSMarker alloc] init];
    
    _meetingPoint.title = @"Origen";
    _meetingPoint.snippet = @"Source";
    _meetingPoint.icon = [UIImage imageNamed:@"iconUbica"];
    _meetingPoint.map = _mapView;
    
    [self updateMeetingPointWithPosition:CLLocationCoordinate2DMake(latitud,longitud) adddress:YES nearestTaxis:YES];
    
    [_locationManager stopUpdatingLocation];
    
//    if (!_meetingPoint) {
//        latitud = newLocation.coordinate.latitude;
//        longitud = newLocation.coordinate.longitude;
//        _currentCamera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude zoom:CAMERA_ZOOM_DEFAULT];
//        
//        _mapView.myLocationEnabled = YES;
//        _mapView.camera = _currentCamera;
//        _mapView.delegate = self;
//        
//        _meetingPoint = [[GMSMarker alloc] init];
//        
//        _meetingPoint.title = @"Origen";
//        _meetingPoint.snippet = @"Source";
//        _meetingPoint.icon = [UIImage imageNamed:@"iconUbica"];
//        _meetingPoint.map = _mapView;
//        
//        [self updateMeetingPointWithPosition:CLLocationCoordinate2DMake(latitud,longitud) adddress:YES nearestTaxis:YES];
//        
//        [_locationManager stopUpdatingLocation];
//    }
    
    // Si solo lo necesitamos una vez podemos dejar de actualizar las coordenadas aunque el usuario se mueva.
    
    // [self.locationManager stopUpdatingLocation];
    
    // Si necesitamos una precisión bastante buena, dejaremos unos segundos para que siga actualizando antes de pararlo, ya que la primera vez suele devolver la última posición recogida, por el iOS o por cualquier otra aplicación.
    
    // Si no lo paramos, el método será llamado en función de la precisión establecida cada X metros.
}

#pragma  mark - UIAlertViewDelegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *newNumberTextField = nil;
    NSString *newNumberStr = nil;
    NSString *newAddressStr = nil;
    ESAddressComponent *addressComponent = nil;
    
    newNumberTextField = [alertView textFieldAtIndex:0];
    newNumberStr = newNumberTextField.text;
    
    if (buttonIndex == 1 && [newNumberStr length] > 0) {
        // Cambiar el número de la dirección
        addressComponent = [_currentAddress getAddressComponentOfType:STREET_NUMBER];
        
        _currentAddress.formatted_address = [_currentAddress.formatted_address stringByReplacingOccurrencesOfString:addressComponent.short_name withString:newNumberStr];
        
        addressComponent.long_name = newNumberStr;
        addressComponent.short_name = newNumberStr;
        
        newAddressStr = [_currentAddress getStreetNumberFormatOfAddress];
        
        _addressLbl.text = newAddressStr;
    }
}

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    return [alertView textFieldAtIndex:0].text.length > 0;
}

#pragma  mark - UITextFieldDelegate Methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    return [ESValidator validateAlphanumbericString:newString maxLength:6];
}

#pragma mark - GMSMapViewDelegate Methods

-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position {
    
    static BOOL flag = NO;
    
    if (!_oldMeetingPoint && flag) {
        _oldMeetingPoint = [[GMSMarker alloc] init];
        _oldMeetingPoint.position = CLLocationCoordinate2DMake(_meetingPoint.position.latitude,_meetingPoint.position.longitude);
    } else {
        flag = YES;
    }
    
    _meetingPoint.position = CLLocationCoordinate2DMake(position.target.latitude,position.target.longitude);
}

-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
    
    _currentCamera = position;
    [self updateMeetingPointWithPosition:position.target adddress:YES nearestTaxis:YES];
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    GMSMarker *auxMarker = nil;
    
    NSLog(@"DidTapMarker");
    
    if (marker != _meetingPoint) {
        
        if (_markerSelected == marker) {
            _markerSelected = nil;
            _driverSelected = nil;
        } else {
            for (NSDictionary *taxiMarkerDetail in _taxiMarkerDetail) {
                auxMarker = taxiMarkerDetail[kTaxistaMarkerKey];
                
                if (auxMarker == marker) {
                    _markerSelected = auxMarker;
                    _driverSelected = taxiMarkerDetail[kIdTaxistaKey];
                    break;
                }
            }
        }
        [_mapView setSelectedMarker:_markerSelected];
    }
    
    return YES;
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    ESSnippetView *snippetView = [ESSnippetView loadViewFromNib];
    
    snippetView.nombreLbl.text = _driverSelected.nombre;
    snippetView.placasLbl.text = _driverSelected.vehiculo.placa;
    snippetView.modeloLbl.text = _driverSelected.vehiculo.modelo.descripcion;
    
    return snippetView;
}

#pragma mark - ESMapTaxiRequestViewController Methods Methods

-(void)updateMeetingPointWithPosition:(CLLocationCoordinate2D) position adddress:(BOOL)address nearestTaxis:(BOOL)nearestTaxis
{
    ESUbicacion *ubicacion = nil;
    
    NSLog(@"Call updateMeetingPointWithPosition:");
    
    ubicacion = [[ESUbicacion alloc]initWithCoordinate2D:position];
    _meetingPoint.position = position;

    if (_venueSelected) {
        [self cancelTask:_addressTask];
        [self updateAddressWithText:_venueSelected.name state:StateAddressAvailablePlace];
        _lastVenueSelected = _venueSelected;
        _venueSelected = nil;
    } else if(address) {
        [self cancelTask:_addressTask];
        [self requestAddressWithLocation:ubicacion];
    }
    
    if (nearestTaxis) {
        [self cancelTask:_nearestTaxisTask];
        [self requestPositionNearestTaxisWithClientLocation:ubicacion];
    }
}

-(void)requestPositionNearestTaxisWithClientLocation:(ESUbicacion *)clientLocation
{
    ESTaxistaBusiness *clienteBusiness = nil;
    
    [self updateTaxisAvailableWithState:StateTaxisSearching];
    
    clienteBusiness = [ESTaxistaBusiness new];
    
    _nearestTaxisTask = [clienteBusiness posicionTaxisCercanos:clientLocation completionHandler:^(NSArray *posicionTaxista){
        
        if (posicionTaxista.count > 0) {
            //Crear markers de los taxis
            
            [self cleanTaxis];
            
            _taxiMarkerDetail = [NSMutableArray array];
            
            for (ESUbicacion *posTaxi in posicionTaxista) {
                GMSMarker *taxiMarker = nil;
                ESTaxista *driver = nil;
                
                taxiMarker = [[GMSMarker alloc] init];
                taxiMarker.position = CLLocationCoordinate2DMake(posTaxi.latitud,posTaxi.longitud);
                
                taxiMarker.icon = [UIImage imageNamed:@"taxiUbica"];
                taxiMarker.map = _mapView;
                taxiMarker.appearAnimation = kGMSMarkerAnimationPop;
                
                driver = [ESTaxista lazyTaxista];
                driver.ubicacion = posTaxi;
                
                [_taxiMarkerDetail addObject:@{kIdTaxistaKey: driver,kTaxistaMarkerKey: taxiMarker}];
            }
            
            [self updateTaxisAvailableWithState:StateTaxisAvailable];
        }
    } errorHandler:^(NSError *error){
        
    }];
    
    [_nearestTaxisTask resume];
}

-(void)requestAddressWithLocation:(ESUbicacion *)location
{
    ESClienteBusiness *clienteBusiness = nil;

    [self updateAddressWithText:nil state:StateAddressSearching];
    
    clienteBusiness = [ESClienteBusiness new];
    
    _addressTask = [clienteBusiness sugerirDireccion:location completionHandler:^(NSArray *address){
        
        _address = address;
        _currentAddress = [ESAddress getStreetAddress:_address];
        
        if (_currentAddress) {
            NSLog(@"Current Address: %@",_currentAddress);
            
            _addressLbl.text = [_currentAddress getStreetNumberFormatOfAddress];
            _addressLbl.textAlignment = NSTextAlignmentLeft;
            _editButton.hidden = NO;
        } else {
            _addressLbl.text = @"Dirección no disponible";
        }
    } errorHandler:^(NSError * error){
        
        if (_addressTask.state == NSURLSessionTaskStateCanceling) {
            [self updateAddressWithText:nil state:StateAddressNotAvaible];
        }
    }];
    
    [_addressTask resume];
}

-(void)cancelTask:(NSURLSessionDataTask *)task
{
    if (task && task.state == NSURLSessionTaskStateRunning) {
        [task cancel];
    }
}

-(void)updateAddressWithText:(NSString *)text state:(StateAddress)state {
    switch (state) {
        case StateAddressAvailable:
            _addressLbl.text = text;
            _addressLbl.textAlignment = NSTextAlignmentLeft;
            _editButton.hidden = NO;
            break;
        case StateAddressAvailablePlace:
            _addressLbl.text = text;
            _addressLbl.textAlignment = NSTextAlignmentLeft;
            _editButton.hidden = YES;
            break;
        case StateAddressNotAvaible:
            _addressLbl.text = @"Dirección no disponible";
            _addressLbl.textAlignment = NSTextAlignmentCenter;
            _editButton.hidden = YES;
            break;
        case StateAddressSearching:
            _addressLbl.text = NSLocalizedString(LBL_FIND_ADDRESS, nil);
            _addressLbl.textAlignment = NSTextAlignmentCenter;
            _editButton.hidden = YES;
            break;
    }
}

-(void)updateTaxisAvailableWithState:(StateTaxis)state
{
    switch (state) {
        case StateTaxisAvailable:
            _availableTaxisButton.enabled = YES;
            [ESUtils setUpView:_availableTaxisButton cornerRadius:CORNER_RADIOUS backgroundColor:[ESUtils colorFromRGB:COLOR_BUTTON_MAP_ENABLED]];
            break;
        case StateTaxisSearching:
            _availableTaxisButton.enabled = NO;
            [ESUtils setUpView:_availableTaxisButton cornerRadius:CORNER_RADIOUS backgroundColor:[ESUtils colorFromRGB:COLOR_BUTTON_MAP_DISABLED]];
            break;
        default:
            break;
    }
}

-(void)cleanTaxis
{
    for (NSDictionary *taxiMarkerDetail in _taxiMarkerDetail) {
        GMSMarker *taxiMarker = taxiMarkerDetail[kTaxistaMarkerKey];
        taxiMarker.map = nil;
    }
}

@end
