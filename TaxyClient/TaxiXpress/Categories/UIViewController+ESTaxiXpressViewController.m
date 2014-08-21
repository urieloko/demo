//
//  UIViewController+ESTaxiXpressViewController.m
//  TaxiXpress
//
//  Created by Roy on 25/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "UIViewController+ESTaxiXpressViewController.h"

@implementation UIViewController (ESTaxiXpressViewController)

-(void)loadViewController {
    [self loadBackgroundImage];
    [self addMenuButton];
    [self loadNavigationBar];
    
}

-(void)loadBackgroundImage {
    
    if([UIScreen mainScreen].bounds.size.height > 500)
    {
        //la resolucion es de 4in
       self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud4"]];
    }
    else
    {
        //la resolucion es de 3.5in
       self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud3"]];
    }
}

-(void)loadNavigationBar {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"head"]  forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:(254/255.0) green:(205/255.0) blue:(47/255.0) alpha:1]];
    
}

-(void)addMenuButton {
    UIImage *menuImage = nil;
    UIImage *tImage = nil;
    UIButton *menuBtn = nil;
    UIButton *tBtn = nil;
    UIBarButtonItem *menuBtnItem = nil;
    UIBarButtonItem *tBtnItem = nil;
    
    // Setting NavigationBar
    menuImage = [UIImage imageNamed:@"btnMenu"];
    tImage = [UIImage imageNamed:@"imgTicon"];
    
    menuBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    [menuBtn setImage:menuImage forState:UIControlStateHighlighted];
    [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    tBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    [tBtn setImage:tImage forState:UIControlStateNormal];
    [tBtn setImage:tImage forState:UIControlStateHighlighted];
    tBtn.userInteractionEnabled = NO;
    
    menuBtnItem =[[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    tBtnItem = [[UIBarButtonItem alloc] initWithCustomView:tBtn];
    
    self.navigationItem.leftBarButtonItem = menuBtnItem;
}

-(void)addTitleView:(UIView *)view
{
    self.navigationItem.titleView = view;
}

-(void)addMenuButtonWithSelector:(SEL)selector {
    UIImage *menuImage = nil;
    UIImage *tImage = nil;
    UIButton *menuBtn = nil;
    UIButton *tBtn = nil;
    UIBarButtonItem *menuBtnItem = nil;
    UIBarButtonItem *tBtnItem = nil;
    
    // Setting NavigationBar
    menuImage = [UIImage imageNamed:@"btnMenu"];
    tImage = [UIImage imageNamed:@"imgTicon"];
    
    menuBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    [menuBtn setImage:menuImage forState:UIControlStateHighlighted];
    [menuBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [menuBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    tBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20,20)];
    [tBtn setImage:tImage forState:UIControlStateNormal];
    [tBtn setImage:tImage forState:UIControlStateHighlighted];
    tBtn.userInteractionEnabled = NO;
    
    menuBtnItem =[[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    tBtnItem = [[UIBarButtonItem alloc] initWithCustomView:tBtn];
    
    self.navigationItem.leftBarButtonItem = menuBtnItem;
}

-(void)addBackButton {
    UIImage *backImage = nil;
    UIButton *backBtn = nil;
    UIBarButtonItem *backBtnItem = nil;
    
    // Setting NavigationBar
    backImage = [UIImage imageNamed:@"btnBack"];
    backBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:backImage forState:UIControlStateHighlighted];
    
    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    backBtnItem =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    self.navigationItem.rightBarButtonItem = backBtnItem;
}
-(void)addAboutButton {
    UIButton *aboutBtn = nil;
    UIBarButtonItem *aboutBtnItem = nil;
    [UINavigationBar appearance].tintColor = [UIColor colorWithRed:(254/255.0) green:(205/255.0) blue:(47/255.0) alpha:1];
   aboutBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [aboutBtn addTarget:self action:@selector(aboutPopView:) forControlEvents:UIControlEventTouchUpInside];
    aboutBtnItem =[[UIBarButtonItem alloc] initWithCustomView:aboutBtn];
    
    self.navigationItem.rightBarButtonItem = aboutBtnItem;
}

-(void)addBackButtonToLeft {
    UIImage *backImage = nil;
    UIButton *backBtn = nil;
    UIBarButtonItem *backBtnItem = nil;
    
    [self loadBackgroundImage];
    
    // Setting NavigationBar
    backImage = [UIImage imageNamed:@"btnBack"];
    backBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:backImage forState:UIControlStateHighlighted];
    
    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    backBtnItem =[[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

-(void)addShareButtonToRight {
    UIBarButtonItem *shareBtnItem = nil;
    [UINavigationBar appearance].tintColor = [UIColor colorWithRed:(254/255.0) green:(205/255.0) blue:(47/255.0) alpha:1];
    [self loadBackgroundImage];
    // Setting NavigationBar
 shareBtnItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareData:)];
    
    
    self.navigationItem.rightBarButtonItem = shareBtnItem;
}

-(void)addBackButtonAndShareToRight {
    UIImage *backImage = nil;
    UIButton *backBtn = nil;
    UIBarButtonItem *backBtnItem = nil;
    UIBarButtonItem *shareBtnItem = nil;
    NSArray *myButtonArray = nil;
    
    [self loadBackgroundImage];
    [UINavigationBar appearance].tintColor = [UIColor colorWithRed:(254/255.0) green:(205/255.0) blue:(47/255.0) alpha:1];
    // Setting NavigationBar
    backImage = [UIImage imageNamed:@"btnBack"];
    shareBtnItem =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareData:)];
    
    backBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setImage:backImage forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
    backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    myButtonArray = [[NSArray alloc] initWithObjects:backBtnItem,shareBtnItem,nil];
    
    self.navigationItem.rightBarButtonItems = myButtonArray;
}
-(void)addFourSquareItemButtonWithSelector:(SEL)selector {
    UIImage *fourSquareImage = nil;
    UIButton *fourSquareBtn = nil;
    UIBarButtonItem *fourSquareBtnItem = nil;
    
    // Setting NavigationBar
    fourSquareImage = [UIImage imageNamed:@"iconoGas"];
    fourSquareBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, fourSquareImage.size.width, fourSquareImage.size.height)];
    [fourSquareBtn setImage:fourSquareImage forState:UIControlStateNormal];
    [fourSquareBtn setImage:fourSquareImage forState:UIControlStateHighlighted];
    
    [fourSquareBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    fourSquareBtnItem =[[UIBarButtonItem alloc] initWithCustomView:fourSquareBtn];
    
    
    self.navigationItem.rightBarButtonItem = fourSquareBtnItem;
}
-(void)aboutPopView:(id)sender {
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(LBL_ABOUT, nil) delegate:nil cancelButtonTitle:NSLocalizedString(LBL_ACCEPT, nil) otherButtonTitles:nil];
    [alert show];
}
- (void)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareData: (id)sender {
    NSString *leyendaTxt = NSLocalizedString(@"Estoy utilizando @Taxy, y me encanta http://taxy.extend.com.mx", nil);
    NSArray* dataToShare = @[leyendaTxt];
    
    UIActivityViewController* activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:dataToShare
                                      applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:^{}];
}
@end
