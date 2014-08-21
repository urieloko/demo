//
//  ESFoursquareBusiness.m
//  TaxiXpress
//
//  Created by Roy on 18/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESFoursquareBusiness.h"
#import "ESAppDelegate.h"

@implementation ESIconDownloadInfo

-(id)initWithIcon:(ESIcon *)icon
{
    self = [super init];
    
    if (self) {
        _icon = icon;
        _downloadTask = nil;
        _iconImage = nil;
        _numberTrial = 0;
        _isDownloading = NO;
        _downloadCompleted = NO;
        _downloadFailed = NO;
        _taskIdentifier = -1;
    }
    
    return self;
}

-(void)setDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    _downloadTask = downloadTask;
    _numberTrial++;
    _isDownloading = YES;
    _downloadCompleted = NO;
    _downloadFailed = NO;
    _taskIdentifier = _downloadTask.taskIdentifier;
    
    [_downloadTask resume];
}

-(void)completed
{
    _isDownloading = NO;
    _downloadCompleted = YES;
    _downloadFailed = NO;
}

-(void)failed
{
    _isDownloading = NO;
    _downloadCompleted = NO;
    _downloadFailed = YES;
    _taskIdentifier = -1;
    _numberTrial++;
}

-(void)cancel
{
    [_downloadTask cancel];
    _downloadTask = nil;
    _isDownloading = NO;
    _downloadCompleted = NO;
    _downloadFailed = YES;
    _taskIdentifier = -1;
}

-(BOOL)isEqual:(id)object
{
    ESIconDownloadInfo *otherIconDownloadInfo = nil;
    
    if ([object isKindOfClass:[ESIconDownloadInfo class]]) {
        otherIconDownloadInfo = (ESIconDownloadInfo *)object;
        
        return [self.icon isEqual:otherIconDownloadInfo.icon];
    }
    return NO;
}

-(NSUInteger)hash
{
    return [_icon hash];
}

@end

@interface ESFoursquareBusiness ()

@property (nonatomic,strong) NSURLSessionDataTask *nearbyLocationsTask;

@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSMutableSet *iconDownloadInfo;
@property (atomic,strong) NSMutableDictionary *foursquareImage;
@property (atomic,strong) void(^completionBlock)(ESIcon* icon);

-(void)setUp;
-(void)prepareCache;
-(void)createCache;
-(void)deleteCache;
-(void)prepareDownLoader;
-(void)loadImages;
-(void)downloadIconsWithVenues:(NSArray *)venues;
-(ESIconDownloadInfo *)getIconDownloadInfoWithTaskIdentifier:(unsigned long)taskIdentifier;
@end

@implementation ESFoursquareBusiness

-(id)initWithCompletionHandler:(void (^)(ESIcon* icon)) completionBlock
{
    self = [super init];
    
    if (self) {
        _completionBlock = completionBlock;
        [self setUp];
    }
    
    return self;
}

-(void)setUp
{
    [self prepareCache];
    [self prepareDownLoader];
}

-(void)prepareCache
{
    NSFileManager *fileMgr = nil;
    NSArray *dirPaths = nil;
    NSString *docsDir = nil;
    NSString *iconDir = nil;
    
    _foursquareImage = [NSMutableDictionary dictionary];
    _iconDownloadInfo = [NSMutableSet set];
    
    fileMgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    iconDir = [docsDir stringByAppendingPathComponent:IMAGE_FOLDER_NAME];
    
    
    NSLog(@"DOCUMENT DIRECTORY [%@]",docsDir);
    NSLog(@"ICON DIRECTORY [%@]",iconDir);
    
    if ([fileMgr changeCurrentDirectoryPath:iconDir]) {
        [self loadImages];
        //Borrar
//        [self deleteCache];
    } else {
        // Crear directorio
        [self createCache];
    }
}

-(void)createCache
{
    NSFileManager *filemgr;
    NSArray *dirPaths;
    NSString *docsDir;
    NSString *newDir;
    
    filemgr =[NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    newDir = [docsDir stringByAppendingPathComponent:IMAGE_FOLDER_NAME];
    
    if ([filemgr createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error:NULL] == NO) {
        NSLog(@"Directory [%@] create failed",newDir);
    } else {
        NSLog(@"Directory [%@] create success",newDir);
    }
}

-(void)deleteCache
{
    NSFileManager *filemgr;
    NSArray *dirPaths;
    NSString *docsDir;
    NSString *deleteDir;
    
    filemgr =[NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    deleteDir = [docsDir stringByAppendingPathComponent:IMAGE_FOLDER_NAME];
    
    if ([filemgr removeItemAtPath: deleteDir error: nil] == NO) {
        NSLog(@"Directory [%@] removal failed",deleteDir);
    } else {
        NSLog(@"Directory [%@] removal success",deleteDir);
    }
}

-(void)prepareDownLoader
{
    NSURLSessionConfiguration *sessionConfiguration = nil;
    
    sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfiguration:FOURSQUARE_BUSSINESS_SESSION];
    sessionConfiguration.HTTPMaximumConnectionsPerHost = MAX_CONNECTIONS_PER_HOST;
    
    _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    
    _nearbyLocationsTask = nil;
}

-(void)loadImages
{
    NSFileManager *filemgr;
    NSArray *filelist;
    NSArray *dirPaths = nil;
    NSString *docsDir = nil;
    NSString *iconDir = nil;
    int count;
    int i;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    iconDir = [docsDir stringByAppendingPathComponent:IMAGE_FOLDER_NAME];
    
    filemgr =[NSFileManager defaultManager];
    filelist = [filemgr contentsOfDirectoryAtPath:iconDir error:NULL];
    count = [filelist count];
    
    for (i = 0; i < count; i++) {
        
        if (filelist[i] && ((NSString *)filelist[i]).lastPathComponent) {
            [_foursquareImage setObject:[UIImage imageWithContentsOfFile:filelist[i]] forKey:((NSString *)filelist[i]).lastPathComponent];
            NSLog(@"%@", filelist[i]);
        }
    }
}

-(void)downloadIconsWithVenues:(NSArray *)venues
{
    int count = 0;
    [self cancelIconDownloaders];
    
    for (ESVenue *venue in venues) {
        ESIconDownloadInfo *iconDownloadInfo = nil;
        
        if (venue.categories.count > 0) {
            iconDownloadInfo = [[ESIconDownloadInfo alloc] initWithIcon:((ESCategory *)(venue.categories[0])).icon];
            
            if (![_foursquareImage objectForKey:[iconDownloadInfo.icon getNameIcon]]) {
                [_iconDownloadInfo addObject:iconDownloadInfo];
            }
        }
    }
    
    for (ESIconDownloadInfo *iconDownloadInfo in _iconDownloadInfo) {
        if (!iconDownloadInfo.isDownloading || (iconDownloadInfo.downloadFailed && iconDownloadInfo.numberTrial <= MAX_TRIALS_IMAGE)) {
            [iconDownloadInfo setDownloadTask:[_session downloadTaskWithURL:[(iconDownloadInfo.icon) getUrl]]];
            count++;
        }
        
        if (count >= MAX_CONNECTIONS_PER_HOST) {
            break;
        }
    }
}

-(ESIconDownloadInfo *)getIconDownloadInfoWithTaskIdentifier:(unsigned long)taskIdentifier
{
    for (ESIconDownloadInfo *iconDownloadInfo in _iconDownloadInfo) {
        if (iconDownloadInfo.taskIdentifier == taskIdentifier) {
            return iconDownloadInfo;
        }
    }
    return nil;
}

-(UIImage *)getIconWithIcon:(ESVenue *)venue
{
    UIImage *image = nil;
    NSArray *categories = venue.categories;
    ESIcon *icon = categories && categories.count > 0?((ESCategory *)(categories[0])).icon : nil;
    
    if (icon) {
        image = [_foursquareImage objectForKey:[icon getNameIcon]];
    }
    
    return image;
}

-(void)cancelIconDownloaders
{
    for (ESIconDownloadInfo *iconDownloadInfo in _iconDownloadInfo) {
        if (iconDownloadInfo.isDownloading) {
            [iconDownloadInfo cancel];
        }
    }
}

-(void)nearbyLocationsWithSearchVenues:(ESSearchVenues *)searchVenues completionHandler:(void (^)(NSArray *venue)) completionBlock errorHandler:(void (^)(NSError *error)) errorBlock
{
    ESFourSquareWS *fourSquareWS = [ESFourSquareWS new];
    
    [self cancelNearbyLocation];
    
    _nearbyLocationsTask = [fourSquareWS searchPlacesWithSearchVenue:searchVenues
                                                   completionHandler:^(NSArray *venue){
                                                       [self downloadIconsWithVenues:venue];
                                                       completionBlock(venue);
                                                   }
                                                        errorHandler:^(NSError *error){
                                                            if (_nearbyLocationsTask.state == NSURLSessionTaskStateCanceling) {
                                                                errorBlock(error);
                                                            }
                                                        }];
    
    [_nearbyLocationsTask resume];
}

-(void)cancelNearbyLocation
{
    if (_nearbyLocationsTask  && _nearbyLocationsTask.state != NSURLSessionTaskStateCanceling) {
        [_nearbyLocationsTask cancel];
        _nearbyLocationsTask = nil;
    }
}

-(BOOL)isRunningNearbyLocation
{
    return _nearbyLocationsTask && _nearbyLocationsTask.state == NSURLSessionTaskStateRunning;
}

#pragma mark - NSURLSessionDelegate Methods

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSArray *dirPaths = nil;
    NSString *docsDir = nil;
    NSString *iconDir = nil;
    NSFileManager *fileManager = nil;
    NSError *error = nil;
    NSString *destinationFilename = nil;
    NSURL *destinationURL = nil;
    BOOL success = NO;
    ESIconDownloadInfo *iconDownloadInfo = nil;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    iconDir = [docsDir stringByAppendingPathComponent:IMAGE_FOLDER_NAME];
    
    
    fileManager = [NSFileManager defaultManager];
    
    destinationFilename = downloadTask.originalRequest.URL.lastPathComponent;
    destinationURL = [[NSURL fileURLWithPath:iconDir isDirectory:YES] URLByAppendingPathComponent:destinationFilename];
    
    if ([fileManager fileExistsAtPath:[destinationURL path]]) {
        [fileManager removeItemAtURL:destinationURL error:nil];
    }
    
    success = [fileManager copyItemAtURL:location
                                        toURL:destinationURL
                                        error:&error];
    
    iconDownloadInfo = [self getIconDownloadInfoWithTaskIdentifier:downloadTask.taskIdentifier];
    
    if (success) {
        [_foursquareImage setObject:[UIImage imageWithContentsOfFile:[destinationURL path]] forKey:destinationURL.lastPathComponent];
        
        [iconDownloadInfo completed];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _completionBlock(iconDownloadInfo.icon);
        }];
        
        for (ESIconDownloadInfo *iconDownloadInfo in _iconDownloadInfo) {
            if ( (!iconDownloadInfo.isDownloading && !iconDownloadInfo.downloadCompleted) || (iconDownloadInfo.downloadFailed && iconDownloadInfo.numberTrial <= MAX_TRIALS_IMAGE)) {
                [iconDownloadInfo setDownloadTask:[_session downloadTaskWithURL:[(iconDownloadInfo.icon) getUrl]]];
                break;
            }
        }
//        // Change the flag values of the respective FileDownloadInfo object.
//        int index = [self getFileDownloadInfoIndexWithTaskIdentifier:downloadTask.taskIdentifier];
//        FileDownloadInfo *fdi = [self.arrFileDownloadData objectAtIndex:index];
//        
//        fdi.isDownloading = NO;
//        fdi.downloadComplete = YES;
//        
//        // Set the initial value to the taskIdentifier property of the fdi object,
//        // so when the start button gets tapped again to start over the file download.
//        fdi.taskIdentifier = -1;
//        
//        // In case there is any resume data stored in the fdi object, just make it nil.
//        fdi.taskResumeData = nil;
//        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            // Reload the respective table view row using the main thread.
//            [self.tblFiles reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
//                                 withRowAnimation:UITableViewRowAnimationNone];
//            
//        }];
        
    }
    else{
        [iconDownloadInfo failed];
        NSLog(@"Unable to copy temp file. Error: %@", [error localizedDescription]);
    }
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    ESIconDownloadInfo *iconDownloadInfo = nil;
    
    iconDownloadInfo = [self getIconDownloadInfoWithTaskIdentifier:task.taskIdentifier];
    
    if (error) {
        [iconDownloadInfo failed];
        NSLog(@"Download completed with error: %@", [error localizedDescription]);
    }
    else{
        NSLog(@"Download finished successfully [%@]",[iconDownloadInfo.icon getNameIcon]);
    }
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    
    NSLog(@"URLSessionDidFinishEventsForBackgroundURLSession");
//    ESAppDelegate *appDelegate = (ESAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    // Checar si todas las descargas han terminado
//    [_session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
//        
//        int pendignRequestCounter = 0;
//        
//        for (ESIconDownloadInfo *iconDownloadInfo in _iconDownloadInfo) {
//            if (iconDownloadInfo.isDownloading || (iconDownloadInfo.downloadFailed && iconDownloadInfo.numberTrial <= MAX_TRIALS_IMAGE)) {
//                pendignRequestCounter++;
//            }
//        }
//        
//        
//        if ([downloadTasks count] == 0 && pendignRequestCounter == 0) {
//            if (appDelegate.backgroundTransferCompletionHandler != nil) {
//                
//                void(^completionHandler)() = appDelegate.backgroundTransferCompletionHandler;
//                
//                appDelegate.backgroundTransferCompletionHandler = nil;
//                
//                NSLog(@"ALL BACKGROUND DOWNLOADS HAVE FINISHED");
//                
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    
//                    // Avisar al completion handler para decirle al sistema que no hay otras transferencias en background
//                    completionHandler();
//                }];
//            }
//        }
//    }];
}

@end
