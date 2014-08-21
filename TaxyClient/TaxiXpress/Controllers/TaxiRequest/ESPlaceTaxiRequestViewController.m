//
//  ESPlaceTaxiRequestViewController.m
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESPlaceTaxiRequestViewController.h"
#import "ESUtils.h"
#import "SVProgressHUD.h"

#define ID_CELL @"placeIdCell"
#define TAG_VIEW_CONTAINER 1
#define TAG_TITLE 2
#define TAG_SUBTITLE 3
#define TAG_IMAGE_VIEW 4
#define HEIGHT_CELL 70.0

@interface ESPlaceTaxiRequestViewController ()
@property (strong, nonatomic) IBOutlet UITableView *placeTableView;
@property (strong, nonatomic) IBOutlet UIView *sloganContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *sloganImage;
@property (strong, nonatomic) IBOutlet UILabel *sloganLabel;


-(void)setUpView;
-(void)reloadRowsWithIcon:(ESIcon *)icon;

@end

@implementation ESPlaceTaxiRequestViewController

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
    [self setUpView];
}

-(void)setUpView
{
    _sloganContainerView.backgroundColor = [ESUtils colorFromRGB:COLOR_AQUA_PLACE];
    [ESUtils setUpLabel:_sloganLabel text:@"Powered by Foursquare" font:[ESUtils fontTrebuchetMsWithSize:SIZE_SMAL] color:[UIColor whiteColor]];
    
    _foursquareBusiness = [[ESFoursquareBusiness alloc] initWithCompletionHandler:^(ESIcon *icon){
        [self reloadRowsWithIcon:icon];
//        [_placeTableView reloadData];
    }];
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
    static NSString *cellIdentifier = ID_CELL;
    UITableViewCell *cell = [_placeTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    ESVenue *venue = nil;
    UIView *containerView = nil;
    UIImageView *imageView = nil;
    UILabel *titleLbl = nil;
    UILabel *subTitleLbl = nil;
    UIColor *color = nil;
    UIImage *image = nil;
    
    venue = (ESVenue *)_venue[indexPath.row];
    
    containerView = [cell viewWithTag:TAG_VIEW_CONTAINER];
    titleLbl = (UILabel *)[cell viewWithTag:TAG_TITLE];
    subTitleLbl = (UILabel *)[cell viewWithTag:TAG_SUBTITLE];
    imageView = (UIImageView *)[containerView viewWithTag:TAG_IMAGE_VIEW];
    
    
    color = indexPath.row % 2 == 0 ? [ESUtils colorFromRGB:COLOR_YELLOW_PLACE] : [ESUtils colorFromRGB:COLOR_ORANGE_PLACE];
    
    [ESUtils setUpView:containerView cornerRadius:CORNER_RADIOUS backgroundColor:color];
    
    titleLbl.text = venue.name;
    titleLbl.textColor = [ESUtils colorFromRGB:COLOR_TITLE_CELL_PLACE];
    titleLbl.font = [ESUtils fontTrebuchetBoldMsWithSize:SIZE_TITLE_CELL_PLACE];
    
    subTitleLbl.text = venue.location.direccion ? venue.location.direccion: @"";
    subTitleLbl.textColor = [ESUtils colorFromRGB:COLOR_SUBTITLE_CELL_PLACE];
    subTitleLbl.font = [ESUtils fontTrebuchetBoldMsWithSize:SIZE_SUBTITLE_CELL_PLACE];
    
    image = [_foursquareBusiness getIconWithIcon:venue];
    
    if (image) {
        imageView.image = image;
        imageView.hidden = NO;
    } else {
        imageView.hidden = YES;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)reloadRowsWithIcon:(ESIcon *)icon
{
//    int i = 0;
//    ESVenue *venue = nil;
//    NSArray *categories = nil;
//    ESCategory *category = nil;
//    UITableViewCell *cell = nil;
//    UIView *containerView = nil;
//    UIImageView *imageView = nil;
//    
//    for (; i < _venue.count; i++) {
//        venue = (ESVenue *)_venue[i];
//        categories = venue.categories;
//        
//        if (categories.count > 0) {
//            category = (ESCategory *)categories[0];
//            
//            if ([category.icon isEqual:icon]) {
//                cell = [_placeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//                containerView = [cell viewWithTag:TAG_VIEW_CONTAINER];
//                imageView = (UIImageView *)[containerView viewWithTag:TAG_IMAGE_VIEW];
//                
//                imageView.image = [_foursquareBusiness getIconWithIcon:venue];
//                imageView.hidden = NO;
//            }
//        }
//    }
    
    NSMutableArray *indexPath = [NSMutableArray array];
    int i = 0;
    ESVenue *venue = nil;
    NSArray *categories = nil;
    ESCategory *category = nil;
    
    for (; i < _venue.count; i++) {
        venue = (ESVenue *)_venue[i];
        categories = venue.categories;
        
        if (categories.count > 0) {
            category = (ESCategory *)categories[0];
            
            if ([category.icon isEqual:icon]) {
                [indexPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
        }
    }
    
    if (indexPath.count > 0) {
        [_placeTableView reloadRowsAtIndexPaths:[indexPath mutableCopy] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - Methods

-(void)cleanPlaces {
    _venue = nil;
    [_placeTableView reloadData];
}

-(void)requestPlacesWithSearchVenue:(ESSearchVenues *)searchVenues
{
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:@"Uuups" message:@"No se encontraron lugares cercanos" delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
    
    [self showProgress];
    
    if (!_foursquareBusiness) {
        _foursquareBusiness = [[ESFoursquareBusiness alloc] initWithCompletionHandler:^(ESIcon *icon){
            [self reloadRowsWithIcon:icon];
            //        [_placeTableView reloadData];
        }];
    }
    
    [_foursquareBusiness nearbyLocationsWithSearchVenues:searchVenues completionHandler:^(NSArray *venue){
        _venue = venue;
        [self hideProgress];
        
        if (_venue.count > 0) {
            [_delegate updateOldMeetingPoint];
            [_placeTableView reloadData];
        } else {
            [alert show];
        }
        
    } errorHandler:^(NSError * error){
        alert.message = @"Ocurrio un error, favor de intentar más tarder";
        
        [alert show];
    }];
}

-(void)cancelRequestPlaces
{
    [_foursquareBusiness cancelNearbyLocation];
    
    [self hideProgress];
}

-(void)showProgress
{
    [ESUtils showProgressWithBackgroundColor:[ESUtils colorFromRGB:COLOR_AQUA_PLACE] foregroundColor:[ESUtils colorFromRGB:COLOR_TITLE_CELL_PLACE] status:NSLocalizedString(LBL_PROGRESS, nil) maskType:SVProgressHUDMaskTypeNone];
}
-(void)hideProgress
{
    [ESUtils hideProgress];
}

#pragma mark - UITableViewDelegate Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _venueSelected = _venue[indexPath.row];
    [_delegate updateMeetingPointWithPlace];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return HEIGHT_CELL;
}

@end
