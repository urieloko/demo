//
//  ESReciboClienteTaxistaViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESReciboClienteTaxistaViewController.h"

@interface ESReciboClienteTaxistaViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblDe;
@property (strong, nonatomic) IBOutlet UILabel *lblOrigen;
@property (strong, nonatomic) IBOutlet UILabel *lblA;
@property (strong, nonatomic) IBOutlet UILabel *lblDestino;
@property (strong, nonatomic) IBOutlet UILabel *lblRecorrido;
@property (strong, nonatomic) IBOutlet UILabel *lblmonto;
@property (strong, nonatomic) IBOutlet UILabel *lblDistancia;
@property (strong, nonatomic) IBOutlet UILabel *lblPrecio;
@property (strong, nonatomic) IBOutlet UIButton *btnContinuar;

@end

@implementation ESReciboClienteTaxistaViewController

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
    [self addBackButtonAndShareToRight];
    [self setUpView];
    // Do any additional setup after loading the view.
}
-(void)setUpView {
    _lblDe.text = NSLocalizedString(@"De", nil);
    _lblA.text = NSLocalizedString(@"A", nil);
    _lblRecorrido.text = NSLocalizedString(@"Recorrido", nil);
    _lblmonto.text = NSLocalizedString(@"Monto", nil);
    [_btnContinuar setTitle:NSLocalizedString(BTN_CONTINUE, nil) forState:UIControlStateNormal];
    _taxistaImg.image = _taxista.imagen;
    _nombreLbl.text = [NSString stringWithFormat:@"%@ %@",_taxista.nombre,_taxista.apellidos];
    _placasLbl.text = _taxista.vehiculo.placa;
    _modeloLbl.text = [NSString stringWithFormat:@"%@, %@",_taxista.vehiculo.modelo.marcaVehiculo.descripcion,_taxista.vehiculo.modelo.descripcion];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
