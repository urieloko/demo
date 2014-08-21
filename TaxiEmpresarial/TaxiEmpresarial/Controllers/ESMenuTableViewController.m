//
//  ESMenuTableViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias Escobar on 10/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESMenuTableViewController.h"
#import "ESRootTaxiRequestViewController.h"
#import "RBStoryboardSegue.h"
#import "RBStoryboardPushSegue.h"
#import "ESSettingsConstants.h"
#import "GPPSignIn.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ESMenuTableViewController ()
@property (strong,nonatomic) NSArray *menuMyAccount;
@property (strong,nonatomic) NSArray *menuGeneral;
@property UIImage *menuImage;
@property NSString *nombreStr;
@property NSArray *sectionIdentifier;
@property NSMutableArray *arrayMenu;
@property NSMutableArray *array;
@property (strong,nonatomic) IBOutlet UITableView *menuTableView;
@end

@implementation ESMenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIEdgeInsets insent = UIEdgeInsetsMake(27, 0, 0, 0);
    _menuTableView.contentInset = insent;
    _menuGeneral = @[@"miPerfil",@"salir"];
    _menuMyAccount = @[@"inicio",@"tarifas",@"ayuda"];
    NSArray *firstSection = [NSArray arrayWithObjects:NSLocalizedString(LBL_MENU_HOME, nil), NSLocalizedString(@"Tarifas", nil),NSLocalizedString(LBL_MENU_HOWTO, nil), nil];
	NSArray *secondSection = [NSArray arrayWithObjects:NSLocalizedString(LBL_MENU_PROFILE, nil), NSLocalizedString(LBL_MENU_LOGOUT, nil), nil];
    _arrayMenu = [[NSMutableArray alloc] initWithObjects:_menuMyAccount,_menuGeneral, nil];
   _array = [[NSMutableArray alloc] initWithObjects:firstSection, secondSection, nil];
	[self setContentsList:_arrayMenu];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{/*
    if ( [segue.destinationViewController isKindOfClass: [RBStoryboardPushSegue class]])
    {
        RBStoryboardPushSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        SWRevealViewController* rvc = self.revealViewController;
        NSAssert( rvc != nil, @"oops! must have a revealViewController" );
        
        NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );
        
        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc)
        {    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            [rvc pushFrontViewController:nc animated:YES];
    }
  */

    // configure the segue.
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        
        SWRevealViewController* rvc = self.revealViewController;
        NSAssert( rvc != nil, @"oops! must have a revealViewController" );
        
        NSAssert( [rvc.frontViewController isKindOfClass: [UINavigationController class]], @"oops!  for this segue we want a permanent navigation controller in the front!" );
        
        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc)
        {
            if ([segue.identifier isEqualToString:@"logout"]) {
                [FBSession.activeSession closeAndClearTokenInformation];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:KEY_FB_LOGIN];
                [userDefaults synchronize];
                [[GPPSignIn sharedInstance] signOut];
            }
            
            UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            [rvc pushFrontViewController:nc animated:YES];
            
            
        };
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self contentsList] count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _sectionIdentifier = [[self contentsList] objectAtIndex:section];
	NSInteger rows = [_sectionIdentifier count];
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _sectionIdentifier = [[self contentsList] objectAtIndex:[indexPath section]];
	NSString *CellIdentifier = [_sectionIdentifier objectAtIndex:[indexPath row]];
    NSArray *sectionTitles = [_array objectAtIndex:[indexPath section]];
	NSString *titleForThisRow = [sectionTitles objectAtIndex:[indexPath row]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	}
    UIImageView *imageView = nil;
    UILabel *nombreLbl = nil;
    imageView = (UIImageView *)[cell viewWithTag:1];
    nombreLbl = (UILabel *)[cell viewWithTag:2];
    [nombreLbl setFont:[UIFont fontWithName:@"TrebuchetMS" size:15]];
    [nombreLbl setText:titleForThisRow];
    [imageView setImage:[UIImage imageNamed:CellIdentifier]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 37;
}

#pragma mark - UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   UIAlertView *alert = nil;
    SWRevealViewController* rvc = self.revealViewController;
    UIStoryboard *storyboard = nil;
    UINavigationController* nc = nil;
    UIViewController *dvc = nil;
    switch (indexPath.section) {
            
        case 0:
            if (indexPath.row == 1) {
                alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Tarifa Inicial", nil) message:[NSString stringWithFormat: @"%C Sitio: $34.0\n %C Libre: $8.34\n %C Radio: $25.0", (unichar) 0x2022, (unichar)0x2022, (unichar) 0x2022] delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
                [alert show];
            }else if (indexPath.row == 2) {
                storyboard = [UIStoryboard storyboardWithName:@"ESHelp" bundle:nil];
                dvc = [storyboard instantiateInitialViewController];
                nc = [[UINavigationController alloc] initWithRootViewController:dvc];
                [rvc pushFrontViewController:nc animated:YES];
            }
            break;
            
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view;
    [view setBackgroundColor:[UIColor colorWithRed:0.13f green:0.13f blue:0.13f alpha:1.0f]];
    UILabel *label;
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,37)];
    label = [[UILabel alloc] initWithFrame:CGRectMake(16,0,tableView.frame.size.width,37)];
    label.textColor = [UIColor colorWithRed:0.99f green:0.85f blue:0.02f alpha:1.0f];
    [label setFont:[UIFont fontWithName:FONT_SEGOEUI size:14]];
    NSString *string =@"";
    if (section ==0) {
        string =NSLocalizedString(@"GENERAL", nil);
    }else{
        string =NSLocalizedString(@"MI CUENTA", nil);
    }
    
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor blackColor]];
    return view;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
