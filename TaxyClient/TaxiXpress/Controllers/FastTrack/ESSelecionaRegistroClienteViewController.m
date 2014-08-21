//
//  ESSelecionaRegistroClienteViewController.m
//  TaxiXpress
//
//  Created by Erick on 26/06/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESSelecionaRegistroClienteViewController.h"
#import "UIViewController+ESTaxiXpressViewController.h"
@interface ESSelecionaRegistroClienteViewController ()

@end

@implementation ESSelecionaRegistroClienteViewController

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
    [self loadViewController];
    // Do any additional setup after loading the view.
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
