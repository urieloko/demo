//
//  ESRegistroClienteViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 27/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESRegistroClienteViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
#import "ESMapClientViewController.h"
#import "ESSettingsConstants.h"


@interface ESRegistroClienteViewController ()
@property (strong, nonatomic) IBOutlet UIButton *btnRegistrame;
@property (strong,nonatomic) UIToolbar *numberToolbar;
@property (strong, nonatomic) IBOutlet UIButton *btnRegistrar;
@property (strong, nonatomic) IBOutlet UILabel *lblTituloRegistro;
-(IBAction)hidekeyboard:(id)sender;
@end

@implementation ESRegistroClienteViewController

-(IBAction)hidekeyboard:(id)sender{
    [_correoTextField resignFirstResponder];
    [_nombreTextField resignFirstResponder];
    [_apellidoPatTextField resignFirstResponder];
    [_apellidoMatTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_telefonoTextField resignFirstResponder];
    [_confirmaPassTextField resignFirstResponder];
    self.activeTextField = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{   _numberToolbar = nil;
    [super viewDidLoad];
     [self loadViewController];
    [self addBackButton];
    [self setUpView];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidekeyboard:)];
    gestureRecognizer.delegate = self;
    [_registroScrollView addGestureRecognizer:gestureRecognizer];
    
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
    _lblTituloRegistro.text = NSLocalizedString(@"Ingresa tus Datos", nil);
    _nombreTextField.delegate = self;
    _apellidoPatTextField.delegate = self;
    _apellidoMatTextField.delegate = self;
    _correoTextField.delegate = self;
    _telefonoTextField.delegate = self;
    _passwordTextField.delegate = self;
    _confirmaPassTextField.delegate = self;
    _activeTextField.delegate = self;
    [_btnRegistrar setTitle:NSLocalizedString(@"Registrar", nil) forState:UIControlStateNormal];
    _nombreTextField.placeholder = NSLocalizedString(@"Nombre", nil);
    _apellidoPatTextField.placeholder = NSLocalizedString(@"ApellidoMat", nil);
    _apellidoMatTextField.placeholder = NSLocalizedString(@"ApellidoPat", nil);
    _correoTextField.placeholder = NSLocalizedString(@"Correo", nil);
    _telefonoTextField.placeholder = NSLocalizedString(@"Telefono", nil);
    _passwordTextField.placeholder = NSLocalizedString(@"Contraseña", nil);
    _confirmaPassTextField.placeholder = NSLocalizedString(@"Confirma Contraseña", nil);

    
    _numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    _numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cerrar", nil) style:UIBarButtonItemStyleDone target:self action:@selector(hidekeyboard:)],
                           nil];
    
    _nombreTextField.inputAccessoryView = _numberToolbar;
    _apellidoPatTextField.inputAccessoryView = _numberToolbar;
    _apellidoMatTextField.inputAccessoryView = _numberToolbar;
    _correoTextField.inputAccessoryView = _numberToolbar;
    _telefonoTextField.inputAccessoryView = _numberToolbar;
    _passwordTextField.inputAccessoryView = _numberToolbar;
    _confirmaPassTextField.inputAccessoryView = _numberToolbar;
    
    
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
        // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    _registroScrollView.contentInset = contentInsets;
    _registroScrollView.scrollIndicatorInsets = contentInsets;
    

    
    CGRect aRect = _registroScrollView.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.view.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _activeTextField.frame.origin.y -(keyboardSize.height-35));
        [_registroScrollView setContentOffset:scrollPoint animated:YES];
    }
}
- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _registroScrollView.contentInset = contentInsets;
    _registroScrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
        self.activeTextField = textField;
    
}
- (IBAction)dismissKeyboard:(id)sender {
    [_activeTextField resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeTextField = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - StoryBoard Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *currentBtn = (UIButton *)sender;
    ESMapClientViewController *mapClientVC = segue.destinationViewController;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    switch (currentBtn.tag) {
        case 0:
            NSLog(@"cancelar");
            mapClientVC.action = @"cancelar";
            break;
        case 1:
            NSLog(@"aceptar");
            
            
            [userDefaults setBool:YES forKey:KEY_FB_LOGIN];
            
        default:
            
            break;
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
