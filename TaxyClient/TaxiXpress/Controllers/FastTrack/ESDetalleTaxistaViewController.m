//
//  ESDetalleTaxistaViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESDetalleTaxistaViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESUtils.h"
#import "ESStoryboardConstants.h"
#import "ESRespuestaTaxistaViewController.h"
#import "SVProgressHUD.h"
#import "ESAppDelegate.h"
#import "ESNotificacion.h"
#import "ESSettingsConstants.h"

@interface ESDetalleTaxistaViewController ()

@property (strong, nonatomic) IBOutlet UITableView *comentariosTable;
@property (strong,nonatomic) NSArray *solicitud;
@property (strong,nonatomic) NSString *respuestaTaxista;
@property (strong,nonatomic) NSTimer *cancelarTimer;

-(void)setUpView;
-(void)goToRespuestaTaxistaWithNotification:(NSNotification *)notification;
-(void)cancelarPorTiempoDeEspera;

- (IBAction)pedirTaxi:(id)sender;
@end

@implementation ESDetalleTaxistaViewController
@synthesize starRatingImage = _starRatingImage;
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
    [self addBackButton];
    
    _solicitud = _taxista.solicitud;
 
    
    _starRatingImage.starImage = [UIImage imageNamed:@"star.png"];
    _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"starhighlighted.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 19;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 3;
    _starRatingImage.displayMode=ESStarRatingDisplayAccurate;
    
    [self starsSelectionChanged:_starRatingImage rating:3];
    // This one will use the returnBlock instead of the delegate
    _starRatingImage.returnBlock = ^(float rating )
    {
        NSLog(@"ReturnBlock: Star rating changed to %.1f", rating);
        // For the sample, Just reuse the other control's delegate method and call it
        [self starsSelectionChanged:_starRatingImage rating:rating];
    };
    [self setUpView];
    
    _comentariosTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_comentariosTable reloadData];
    // Do any additional setup after loading the view.
}
-(void)starsSelectionChanged:(ESCalificacion *)control rating:(float)rating
{
    //NSString *ratingString = [NSString stringWithFormat:@"%.1f", rating];
}
-(void)setUpView {
    _taxistaImg.image = _taxista.imagen;
    _lblNombre.text = [NSString stringWithFormat:@"%@ %@",_taxista.nombre,_taxista.apellidos];
    _lblPlacas.text = _taxista.vehiculo.placa;
    _lblModelo.text = [NSString stringWithFormat:@"%@, %@",_taxista.vehiculo.modelo.marcaVehiculo.descripcion,_taxista.vehiculo.modelo.descripcion];
    _lblPermite.text = NSLocalizedString(LBL_RATING, nil);
    _lblServicio.text = NSLocalizedString(@"Servicio Aceptable", nil);
    
    _lblNombre.textColor = [ESUtils colorFromRGB:0xfffbed];
    
    _lblPlacas.textColor = [ESUtils colorFromRGB:0x999999];
    
    _lblModelo.textColor = [ESUtils colorFromRGB:0x999999];

    [_btnPedirTaxi setTitle:NSLocalizedString(BTN_ASK_TAXI, @"") forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NSTimerMethods

-(void)cancelarPorTiempoDeEspera {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    
    [SVProgressHUD dismiss];
    
    [self performSegueWithIdentifier:SG_ID_DETALLE_TAXISTA_TO_MAP_CLIENT sender:self];
}

#pragma mark - Notification Methods
-(void)goToRespuestaTaxistaWithNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSError *error = nil;
    ESNotificacion *notificacion = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    
    [_cancelarTimer invalidate];
    _cancelarTimer = nil;
    
    notificacion = [[ESNotificacion alloc] initWithDictionary:userInfo error:&error];
    
    [SVProgressHUD dismiss];
    
    if ([notificacion.responseDriver isEqualToString:@"cancel"]) {
        [self performSegueWithIdentifier:SG_ID_DETALLE_TAXISTA_TO_MAP_CLIENT sender:self];
    } else {
        _respuestaTaxista = notificacion.responseDriver;
        
        _taxistaMarker = [[GMSMarker alloc] init];
        _taxistaMarker.position = CLLocationCoordinate2DMake([notificacion.latitude doubleValue], [notificacion.longitude doubleValue]);
        
        _taxistaMarker.title = @"Origen";
        _taxistaMarker.snippet = @"Source";
        _taxistaMarker.icon = [UIImage imageNamed:@"taxiUbica"];
        
        [self performSegueWithIdentifier:SG_ID_DETALLE_TAXISTA_TO_RESPUESTA_TAXISTA sender:self];
    }
}

#pragma mark - Actions Methods
- (IBAction)pedirTaxi:(id)sender {
    
    ESAppDelegate *appDelegate = (ESAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.notificationName = NOTIFICACTION_RESPUESTA_TAXISTA;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToRespuestaTaxistaWithNotification:) name:NOTIFICACTION_RESPUESTA_TAXISTA object:nil];
    [ESUtils showProgressWithBackgroundColor:[ESUtils colorFromRGB:0xd8b156] foregroundColor:[UIColor blackColor] status:NSLocalizedString(LBL_PROGRESS, nil) maskType:SVProgressHUDMaskTypeGradient];
    
    _cancelarTimer = [NSTimer timerWithTimeInterval:TIME_OUT_PEDIR_TAXI target:self selector:@selector(cancelarPorTiempoDeEspera) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_cancelarTimer forMode:NSDefaultRunLoopMode];
}

#pragma mark - Storyboard Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ESRespuestaTaxistaViewController *respuestaVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:SG_ID_DETALLE_TAXISTA_TO_RESPUESTA_TAXISTA]) {
        respuestaVC.taxista = _taxista;
        respuestaVC.respuestaTaxista = _respuestaTaxista;
        respuestaVC.clienteMarker = _clienteMarker;
        respuestaVC.taxistaMarker = _taxistaMarker;
    }
}

@end
