//
//  ESFoursquareBusiness.h
//  TaxiXpress
//
//  Created by Roy on 18/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESFourSquareWS.h"

#define IMAGE_FOLDER_NAME @"FoursquareIcons"
#define MAX_TRIALS_IMAGE 3
#define MAX_CONNECTIONS_PER_HOST 5
#define FOURSQUARE_BUSSINESS_SESSION @"FOURSQUARE.BUSINESS"
#define NOTIFICATION_NEW_ICON_DOWNLOAD @"NEW.ICON.DOWNLOAD"
#define NOTIFICATION_ALL_ICON_DOWNLOAD @"ALL.ICON.DOWNLOAD"
#define KEY_ICON_NAME @"ICON.NAME"
#define KEY_ICON_IMAGE @"ICON.IMAGE"

@interface ESIconDownloadInfo : NSObject

@property (nonatomic, strong) ESIcon *icon;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic) int numberTrial;

@property (nonatomic) BOOL isDownloading;

@property (nonatomic) BOOL downloadCompleted;

@property (nonatomic) BOOL downloadFailed;

@property (nonatomic) unsigned long taskIdentifier;

-(id)initWithIcon:(ESIcon *)icon;
-(void)setDownloadTask:(NSURLSessionDownloadTask *)downloadTask;
-(void)completed;
-(void)failed;
-(void)cancel;

-(BOOL)isEqual:(id)object;
-(NSUInteger)hash;

@end

@interface ESFoursquareBusiness : NSObject <NSURLSessionDelegate>

-(id)initWithCompletionHandler:(void (^)(ESIcon* icon)) completionBlock;

-(UIImage *)getIconWithIcon:(ESVenue *)venue;
-(void)cancelIconDownloaders;

-(void)nearbyLocationsWithSearchVenues:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock;
-(void)cancelNearbyLocation;
-(BOOL)isRunningNearbyLocation;

@end
