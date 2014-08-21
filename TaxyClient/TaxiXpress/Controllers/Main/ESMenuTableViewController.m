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

@interface ESMenuTableViewController ()
@property (strong,nonatomic) NSArray *menuSettings;
@property (strong,nonatomic) NSArray *menuLoginSettings;
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
    
    _menuLoginSettings = @[@"inicio",@"miPerfil",@"ayuda",@"salir"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = _menuLoginSettings[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    UILabel *nombreLbl = (UILabel *)[cell viewWithTag:2];
    
    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"inicio";
            nombreLbl.text = NSLocalizedString(LBL_MENU_HOME, nil);
            imageView.image = [UIImage imageNamed:@"inicio"];
            return cell;
        case 1:
            CellIdentifier = @"miPerfil";
            nombreLbl.text = NSLocalizedString(LBL_MENU_PROFILE, nil);
            imageView.image = [UIImage imageNamed:@"miPerfil"];
              return cell;
        case 2:
            CellIdentifier = @"ayuda";
            nombreLbl.text = NSLocalizedString(LBL_MENU_HOWTO, nil);
            imageView.image = [UIImage imageNamed:@"ayuda"];
             return cell;
        case 3:
            CellIdentifier = @"salir";
            nombreLbl.text = NSLocalizedString(LBL_MENU_LOGOUT, nil);
            imageView.image = [UIImage imageNamed:@"salir"];
            return cell;
    }
    
      return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark - UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealViewController* rvc = self.revealViewController;
    UIStoryboard *storyboard = nil;
    UINavigationController* nc = nil;
    UIViewController *dvc = nil;
    switch (indexPath.row) {
        case 2:
            storyboard = [UIStoryboard storyboardWithName:@"ESHelp" bundle:nil];
            dvc = [storyboard instantiateInitialViewController];
            nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            [rvc pushFrontViewController:nc animated:YES];
            break;
            
        default:
            break;
    }
}

/*
- (void)loadArrays {
    NSArray* sections = nil;
    NSMutableArray* msection1 = [[NSMutableArray alloc]init];
    
    for(NSString* modul in sections){
        if([modul isEqualToString:@"0"]){
            [msection1 addObject:@"CFDI"];
        }
        if([modul isEqualToString:@"1"]){
            [msection1 addObject:@"Indicadores"];
        }
        if([modul isEqualToString:@"2"]){
            [msection1 addObject:@"Tutoriales"];
        }
        if([modul isEqualToString:@"3"]){
            [msection1 addObject:@"FeedRSS"];
        }
        if([modul isEqualToString:@"4"]){
            [msection1 addObject:@"RedesSoc"];
        }

        
    }
    [msection1 addObject:@"Configuración"];
    self.section1 = msection1;
    
    self.menu = [NSArray arrayWithObjects:self.section1, nil];
}
*/

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
