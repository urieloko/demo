//
//  ESMapTaxiRequestViewController.h
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ESRootTaxiRequestViewController.h"
#import "ESClienteBusiness.h"
#import "ESTaxistaBusiness.h"
#import "ESValidator.h"

typedef enum : NSUInteger {
    StateAddressAvailable,
    StateAddressNotAvaible,
    StateAddressSearching,
    StateAddressAvailablePlace,
} StateAddress;

typedef enum : NSUInteger {
    StateTaxisAvailable,
    StateTaxisNotAvaible,
    StateTaxisSearching,
} StateTaxis;

@interface ESMapTaxiRequestViewController : UIViewController <GMSMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong) GMSMarker *oldMeetingPoint;
@property(nonatomic,strong) GMSMarker *meetingPoint;
@property (strong, nonatomic) id<ESRootTaxiRequestDelegate>delegate;
@property (strong, nonatomic) NSURLSessionDataTask *addressTask;
@property (strong, nonatomic) NSURLSessionDataTask *nearestTaxisTask;
@property (strong,nonatomic) NSArray *address;
@property (strong,nonatomic) ESAddress *currentAddress;
@property (strong, nonatomic) ESVenue *venueSelected;
@property (strong, nonatomic) ESVenue *lastVenueSelected;
@property (strong, nonatomic) GMSCameraPosition *currentCamera;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property(nonatomic,strong) NSArray *taxistas;


-(void)updateMeetingPointWithPosition:(CLLocationCoordinate2D) position adddress:(BOOL)address nearestTaxis:(BOOL)nearestTaxis;
-(void)requestPositionNearestTaxisWithClientLocation:(ESUbicacion *)clientLocation;
-(void)requestAddressWithLocation:(ESUbicacion *)location;
-(void)cancelTask:(NSURLSessionDataTask *)task;

-(void)updateAddressWithText:(NSString *)text state:(StateAddress)state;
-(void)updateTaxisAvailableWithState:(StateTaxis)state;

-(void)cleanTaxis;
@end
