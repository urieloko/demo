//
//  UIViewController+ESTaxiXpressViewController.h
//  TaxiXpress
//
//  Created by Roy on 25/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESStoryboardConstants.h"


@interface UIViewController (ESTaxiXpressViewController)

-(void)loadViewController;
-(void)loadBackgroundImage;
-(void)loadNavigationBar;
-(void)addMenuButton;
-(void)addTitleView:(UIView *)view;
-(void)addMenuButtonWithSelector:(SEL)selector;
-(void)addBackButton;
-(void)addBackButtonToLeft;
-(void)addFourSquareItemButtonWithSelector:(SEL)selector;
- (void)popViewController:(id)sender;
-(void)addBackButtonAndShareToRight;
-(void)addShareButtonToRight;
-(void)addAboutButton;
-(void)aboutPopView:(id)sender;
@end
