//
//  ESRespuestaTaxistaViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESEvaluacionTaxistaViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"

#define KEY_IDENTIFIER_CELL @"identifier_cell"
#define KEY_SIZE_CELL @"size_cell"
#define CELL_IDENTIFIER0 @"ETCELL0"
#define CELL_IDENTIFIER1 @"ETCELL1"
#define CELL_IDENTIFIER2 @"ETCELL2"

@interface ESEvaluacionTaxistaViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (weak, nonatomic) ESCalificacion *starRatingImage;
@property (weak, nonatomic) UILabel *starRatingImageLabel;
@property (strong, nonatomic) UITextView *comentariosTextView;
@property (strong,nonatomic) NSArray *colors;
@property (strong, nonatomic) IBOutlet UITableView *evaluacionTableView;
@property (strong,nonatomic) NSArray *cellSettings;
@property (strong,nonatomic) NSString *comentario;
@property (strong,nonatomic) UITextView *activeTextView;

-(void)setUpView;
@end

@implementation ESEvaluacionTaxistaViewController

@synthesize starRatingImage = _starRatingImage;
@synthesize starRatingImageLabel = _starRatingImageLabel;
@synthesize cellSettings;

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
    [self setUpView];
    _comentariosTextView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    // Do any additional setup after loading the view.
}


-(void)setUpView {
    [_btncalifica setTitle:NSLocalizedString(@"Calificar", nil) forState:UIControlStateNormal];
    [_btnomitir setTitle:NSLocalizedString(@"Omitir", nil) forState:UIControlStateNormal];
    self.colors = @[ [UIColor colorWithRed:0.11f green:0.38f blue:0.94f alpha:1.0f], [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f], [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f], [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f]];

    _comentario = @"";
    cellSettings = @[@{KEY_IDENTIFIER_CELL: CELL_IDENTIFIER0,KEY_SIZE_CELL: @169.0},@{KEY_IDENTIFIER_CELL: CELL_IDENTIFIER1,KEY_SIZE_CELL: @110.0},@{KEY_IDENTIFIER_CELL: CELL_IDENTIFIER2,KEY_SIZE_CELL: @198.0}];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cerrar", nil) style:UIBarButtonItemStyleDone target:self action:@selector(ocultarTeclado)],
                           nil];
    self.comentariosTextView.inputAccessoryView = numberToolbar;
}
- (void)ocultarTeclado {
    [_comentariosTextView resignFirstResponder];
}
- (void)viewDidUnload
{
[[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setStarRatingImage:nil];
    [self setStarRatingImageLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)starsSelectionChanged:(ESCalificacion *)control rating:(float)rating
{
    NSString *ratingString = [NSString stringWithFormat:@"%.1f", rating];
        _starRatingImageLabel.text = ratingString;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableview DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellSettings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   NSDictionary *identifierDic = cellSettings[indexPath.row];
    NSString *cellIdentifier = identifierDic [KEY_IDENTIFIER_CELL];
    UIToolbar *numberToolbar = nil;
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if ([cellIdentifier isEqualToString:CELL_IDENTIFIER0]) {
        UIImageView *taxistaImage = (UIImageView *)[cell viewWithTag:5];
        UILabel *nombreLbl = (UILabel *)[cell viewWithTag:1];
        UILabel *placasLbl = (UILabel *)[cell viewWithTag:2];
        UILabel *modeloLbl = (UILabel *)[cell viewWithTag:3];
        taxistaImage.image = _taxista.imagen;
        nombreLbl.text = [NSString stringWithFormat:@"%@ %@",_taxista.nombre,_taxista.apellidos];
        placasLbl.text = _taxista.vehiculo.placa;
        modeloLbl.text = [NSString stringWithFormat:@"%@, %@",_taxista.vehiculo.modelo.marcaVehiculo.descripcion,_taxista.vehiculo.modelo.descripcion];
        
    }else if ([cellIdentifier isEqualToString:CELL_IDENTIFIER1]){
        UILabel *lblCalifica = (UILabel *)[cell viewWithTag:4];
        lblCalifica.text = NSLocalizedString(LBL_RATE, nil);
        UILabel *lblComentarios = (UILabel *)[cell viewWithTag:5];
        lblComentarios.text = NSLocalizedString(LBL_COMMENT, nil);
        _starRatingImage = (ESCalificacion *)[cell viewWithTag:1];
        _starRatingImageLabel = (UILabel *)[cell viewWithTag:2];

        
        _starRatingImage.starImage = [UIImage imageNamed:@"star.png"];
        _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"starhighlighted.png"];
        _starRatingImage.maxRating = 5.0;
        _starRatingImage.delegate = self;
        _starRatingImage.horizontalMargin = 19;
        _starRatingImage.editable=YES;
        _starRatingImage.rating= 0;
        _starRatingImage.displayMode=ESStarRatingDisplayAccurate;
        
        [self starsSelectionChanged:_starRatingImage rating:0];
        // This one will use the returnBlock instead of the delegate
        _starRatingImage.returnBlock = ^(float rating )
        {
            NSLog(@"ReturnBlock: Star rating changed to %.1f", rating);
            // For the sample, Just reuse the other control's delegate method and call it
            [self starsSelectionChanged:_starRatingImage rating:rating];
        };

    }else {
        
        _comentariosTextView = (UITextView *)[cell viewWithTag:5];
        
        _comentariosTextView.text = _comentario;
        
        
        numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cerrar", nil) style:UIBarButtonItemStyleDone target:self action:@selector(ocultarTeclado)],
                               nil];
        
        _comentariosTextView.inputAccessoryView = numberToolbar;
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *identifierDic = cellSettings[indexPath.row];
    NSString *cellIdentifier = identifierDic [KEY_IDENTIFIER_CELL];
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ([cellIdentifier isEqualToString:@"ETCELL0"]) {
        return 169;
    }else if ([cellIdentifier isEqualToString:@"ETCELL1"]){
        return 110;
    }else{
        if([UIScreen mainScreen].bounds.size.height > 500)
        {
            //la resolucion es de 4in
            return 110;
        }
        else
        {
            //la resolucion es de 3.5in
            return 65;
        }
        
    }
}
- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _evaluacionTableView.contentInset = contentInsets;
    _evaluacionTableView.scrollIndicatorInsets = contentInsets;
}
- (void) textViewDidBeginEditing:(UITextView *)textView{
    self.activeTextView = textView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextView = nil;
}
- (IBAction)dismissKeyboard:(id)sender
{
    [_activeTextView resignFirstResponder];
}
- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _evaluacionTableView.contentInset = contentInsets;
    _evaluacionTableView.scrollIndicatorInsets = contentInsets;
    
    
    
    CGRect aRect = _evaluacionTableView.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, _comentariosTextView.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _comentariosTextView.frame.origin.y + (keyboardSize.height-15));
        [_evaluacionTableView setContentOffset:scrollPoint animated:YES];
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
