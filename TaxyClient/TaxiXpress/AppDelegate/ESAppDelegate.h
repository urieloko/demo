//
//  ESAppDelegate.h
//  TaxiXpress
//
//  Created by Roy on 24/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//  Versión 1.0
//
// Cambio prueba
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface ESAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong) NSString *notificationName;
@property (nonatomic, copy) void(^backgroundTransferCompletionHandler)();

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;

@end
