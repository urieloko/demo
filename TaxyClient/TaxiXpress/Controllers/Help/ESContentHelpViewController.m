//
//  ESContentHelpViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 07/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESContentHelpViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"

@interface ESContentHelpViewController ()

@end

@implementation ESContentHelpViewController

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
    [self loadBackgroundImage];
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    self.stepLabel.text = self.stepText;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
