//
//  ESListaTaxisViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESListaTaxisViewController.h"
#import "ESDetalleTaxistaViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESTaxistaBusiness.h"
#import "SVProgressHUD.h"
#import "ESUtils.h"


@interface ESListaTaxisViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;



-(void)avisarLlegoTaxi:(NSNotification *)notification;

@end

@implementation ESListaTaxisViewController
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
    [self addBackButtonAndShareToRight];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView reloadData];
    [self setUpView];

    
    // Do any additional setup after loading the view.
}
-(void)setUpView {
  
}
- (void)viewDidUnload
{
    
    [self setStarRatingImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)viewWillAppear:(BOOL)animated {
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _taxista.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"idCellListaTaxis";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    ESTaxista *taxista = nil;
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    taxista = (ESTaxista *)_taxista[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    UILabel *nombreLbl = (UILabel *)[cell viewWithTag:2];
    UILabel *placasLbl = (UILabel *)[cell viewWithTag:3];
    UILabel *modeloLbl = (UILabel *)[cell viewWithTag:4];
    _starRatingImage = (ESCalificacion *)[cell viewWithTag:5];
    
    _starRatingImage.starImage = [UIImage imageNamed:@"star.png"];
    _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"starhighlighted.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 19;
    _starRatingImage.editable=YES;
    _starRatingImage.rating= 4;
    _starRatingImage.displayMode=ESStarRatingDisplayAccurate;
    
    [self starsSelectionChanged:_starRatingImage rating:3];
    // This one will use the returnBlock instead of the delegate
    _starRatingImage.returnBlock = ^(float rating )
    {
        NSLog(@"ReturnBlock: Star rating changed to %.1f", rating);
        // For the sample, Just reuse the other control's delegate method and call it
        [self starsSelectionChanged:_starRatingImage rating:rating];
    };
    
    cell.backgroundColor = [UIColor clearColor];
    
    imageView.image = taxista.imagen;
    nombreLbl.text = [NSString stringWithFormat:@"%@ %@",taxista.nombre,taxista.apellidos];
    nombreLbl.textColor = [UIColor whiteColor];
    
    placasLbl.text = taxista.vehiculo.placa;
    placasLbl.textColor = [ESUtils colorFromRGB:0x999999];
    
    modeloLbl.text = [NSString stringWithFormat:@"%@, %@",taxista.vehiculo.modelo.marcaVehiculo.descripcion,taxista.vehiculo.modelo.descripcion];
    modeloLbl.textColor = [ESUtils colorFromRGB:0x999999];
    
    
    return cell;
}
-(void)starsSelectionChanged:(ESCalificacion *)control rating:(float)rating
{
    NSString *ratingString = [NSString stringWithFormat:@"%.1f", rating];
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80.0;
//}

#pragma mark - UITableViewDelegate Methods
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:SG_ID_SITIOS_CERCANOS_TO_MAP_CLIENT sender:self];
//}

#pragma mark - Storyboard Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ESDetalleTaxistaViewController *detalleTaxistaVC = segue.destinationViewController;
    NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
    
    detalleTaxistaVC.taxista = _taxista[indexPath.row];
    detalleTaxistaVC.clienteMarker = _clienteMarker;
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
