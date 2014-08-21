//
//  ESRootTaxiRequestViewController.h
//  TaxiXpress
//
//  Created by Roy on 08/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "ESSearchVenues.h"
#import "ESLocalizableConstants.h"

@protocol ESRootTaxiRequestDelegate <NSObject>

@required
-(void)updateOldMeetingPoint;
-(void)updateMeetingPointWithPlace;
-(void)lookAvailableDrivers;
@end

@interface ESRootTaxiRequestViewController : UIViewController <ESRootTaxiRequestDelegate>
-(IBAction)regresoRegistroCliente:(UIStoryboardSegue *)segue;
-(IBAction)regresoSitiosCercanos:(UIStoryboardSegue *)segue;
-(IBAction)regresoDetalleTaxista:(UIStoryboardSegue *)segue;
-(IBAction)regresoRespuestaTaxistaSolicitud:(UIStoryboardSegue*)segue;
-(IBAction)regresoCancelaSolicitud:(UIStoryboardSegue*)segue;
-(IBAction)regresoEnviaComentario:(UIStoryboardSegue*)segue;

-(void)manageProgressView;
-(void)showMapView;
-(void)showPlaceView;
-(void)lookAvailableDrivers;

-(void)updateOldMeetingPoint;
-(void)updateMeetingPointWithPlace;

@end
