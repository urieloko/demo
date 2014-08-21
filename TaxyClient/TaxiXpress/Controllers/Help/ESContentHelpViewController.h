//
//  ESContentHelpViewController.h
//  TaxiXpress
//
//  Created by Erick Iglesias on 07/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESContentHelpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property NSString *stepText;
@end
