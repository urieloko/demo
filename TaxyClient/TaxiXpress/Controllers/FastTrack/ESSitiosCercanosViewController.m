//
//  ESSitiosCercanosTableViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 25/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//
#import "ESSitiosCercanosViewController.h"
#import "ESMapClientViewController.h"
#import "SVProgressHUD.h"
#import "ESUtils.h"



@interface ESSitiosCercanosViewController ()
@property (strong,nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ESSitiosCercanosViewController

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
    [self addBackButtonToLeft];
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return _venue.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    ESVenue *venue = nil;
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    venue = (ESVenue *)_venue[indexPath.row];
    
    cell.textLabel.text = venue.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
//    cell.detailTextLabel.text = [@(venue.location.distancia) stringValue];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80.0;
//}

#pragma mark - UITableViewDelegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SG_ID_SITIOS_CERCANOS_TO_MAP_CLIENT sender:self];
}

#pragma mark - Storyboard Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ESMapClientViewController *mapclientVC = segue.destinationViewController;
    NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
    
    mapclientVC.venue = _venue[indexPath.row];
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
