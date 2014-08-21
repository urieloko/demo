//
//  ESrootHelpViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 07/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESContentHelpViewController.h"
#import "ESRootTaxiRequestViewController.h"


@interface ESrootHelpViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *stepTexts;

@end
