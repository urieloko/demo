//
//  ESEsperaConfirmacionViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESRespuestaTaxistaViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ESStoryboardConstants.h"
#import "ESUtils.h"
#import "ESAppDelegate.h"
#import "ESEvaluacionTaxistaViewController.h"

@interface ESRespuestaTaxistaViewController () <UIAlertViewDelegate>



@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property BOOL mostrarTiempoLlegada;
@property (strong, nonatomic) IBOutlet UIButton *btnCancelaViaje;

-(void)setUpView;

@end

@implementation ESRespuestaTaxistaViewController

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
    [self addShareButtonToRight];
    _mostrarTiempoLlegada = YES;
    [self setUpView];
    
    // Configurar notificación remota
    ESAppDelegate *appDelegate = (ESAppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.notificationName = NOTIFICACTION_RESPUESTA_TAXISTA;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avisarLlegoTaxi:) name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    UIAlertView *alert = nil;
    
    if (_mostrarTiempoLlegada) {
        alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", nil) message:[NSString stringWithFormat:NSLocalizedString(@"Su taxi llegará aproximadamente en: %@ minutos", nil),_respuestaTaxista] delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
        [alert show];
        _mostrarTiempoLlegada = NO;
    }
}

-(void)setUpView {
    _clienteMarker = [[GMSMarker alloc]init];
    _taxistaMarker = [[GMSMarker alloc]init];
    _clienteMarker.icon = [UIImage imageNamed:@"iconUbica"];
    _taxistaMarker.icon = [UIImage imageNamed:@"taxiUbica"];
    _clienteMarker.position = CLLocationCoordinate2DMake(19.430793,-99.159201);
    _taxistaMarker.position = CLLocationCoordinate2DMake(19.418094, -99.135716);
    GMSCameraPosition *camera = nil;
    [_btnCancelaViaje setTitle:NSLocalizedString(BTN_CANCEL_TRIP, @"") forState:UIControlStateNormal];
    _taxistaImg.image = _taxista.imagen;
    _nombreLbl.text = [NSString stringWithFormat:@"%@ %@",_taxista.nombre,_taxista.apellidos];
    _placasLbl.text = _taxista.vehiculo.placa;
    _modeloLbl.text = [NSString stringWithFormat:@"%@, %@",_taxista.vehiculo.modelo.marcaVehiculo.descripcion,_taxista.vehiculo.modelo.descripcion];
    
#warning Marcar los puntos en el mapa (cliente y taxista)
    _clienteMarker.map = _mapView;
    _taxistaMarker.map = _mapView;
    camera = [GMSCameraPosition cameraWithLatitude:_clienteMarker.position.latitude longitude:_clienteMarker.position.longitude zoom:13.0];
    _mapView.camera = camera;
    
    _taxistaSolicitudLbl.text = NSLocalizedString(@"El taxista aceptó su solicitud", nil);
    
}
- (IBAction)verTaxiCancelarBtn:(id)sender {
    NSString *mensaje = NSLocalizedString(@"¿Seguro que desea cancelar?", nil);
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", nil) message:mensaje delegate:self cancelButtonTitle:NSLocalizedString(@"SI", nil) otherButtonTitles:NSLocalizedString(@"NO", nil), nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertViewDelegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"respuestaTaxistaToMapClient" sender:self];
    }
}

#pragma mark - NSNotificationCenter Methods
-(void)avisarLlegoTaxi:(NSNotification *)notification {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Aviso", nil) message:NSLocalizedString(@"El taxi ha llegado al punto de encuento", nil) delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
    // Configurar notificación remota
    ESAppDelegate *appDelegate = (ESAppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.notificationName = NOTIFICACTION_RESPUESTA_TAXISTA;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToEvaluacionTaxista:) name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    
    [alert show];
}

-(void)goToEvaluacionTaxista:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    
    [self performSegueWithIdentifier:SG_ID_RESPUESTA_TAXISTA_TO_EVALUACION_TAXISTA sender:self];
}

#pragma mark - Storyboard Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:SG_ID_RESPUESTA_TAXISTA_TO_EVALUACION_TAXISTA]) {
        ((ESEvaluacionTaxistaViewController *)vc).taxista = _taxista;
    }else if ([segue.identifier isEqualToString:@"respuestaTaxistaToReciboViewController"]) {
        ((ESEvaluacionTaxistaViewController *)vc).taxista = _taxista;
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
