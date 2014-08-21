//
//  ESMasDetalleTaxistaViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 09/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESMasDetalleTaxistaViewController.h"

@interface ESMasDetalleTaxistaViewController ()
@property (strong, nonatomic) IBOutlet UITableView *comentariosTable;
@property (strong,nonatomic) NSArray *solicitud;
- (void) setupView;
@end

@implementation ESMasDetalleTaxistaViewController

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
    [self setupView];
    _solicitud = _taxista.solicitud;
}
- (void) setupView {
    _lblAbordo.text = NSLocalizedString(LBL_ONBOARD, nil);
    _lblTarifa.text = NSLocalizedString(@"Tarifa Inicial", nil);
    _lblComentario.text = NSLocalizedString(LBL_COMMENT, nil);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Tabla Comentarios
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_solicitud count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"comentarioCell";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //uncomment to get the time only
    //[formatter setDateFormat:@"hh:mm a"];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dateToday = [formatter stringFromDate:[NSDate date]];
    UITableViewCell *cell = nil;
    UILabel *nombreLbl = nil;
    UILabel *comentarioLbl = nil;
    ESSolicitud *solicitud = nil;
    ESCliente *cliente = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    nombreLbl = (UILabel *)[cell viewWithTag:1];
    comentarioLbl = (UILabel *)[cell viewWithTag:2];
    
    nombreLbl.textColor = [ESUtils colorFromRGB:0xeb8604];
    comentarioLbl.textColor = [ESUtils colorFromRGB:0xfffbed];
    
    solicitud = _solicitud[indexPath.row];
    cliente = solicitud.cliente;
    
    nombreLbl.text = [NSString stringWithFormat:@"Sr(a): %@   - %@",cliente.nombre,dateToday];
    comentarioLbl.text = solicitud.comentario;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89.0;
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
