//
//  ESrootHelpViewController.m
//  TaxiXpress
//
//  Created by Erick Iglesias on 07/07/14.
//  Copyright (c) 2014 Extend Solutions. All rights reserved.
//

#import "ESrootHelpViewController.h"
#import "ESStoryboardConstants.h"
#import "UIViewController+ESTaxiXpressViewController.h"


@interface ESrootHelpViewController ()

@end

@implementation ESrootHelpViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBackgroundImage];
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
	// Create the data model
    _pageTitles = @[NSLocalizedString(@"Indique su ubicación y solicite el taxi deseado", nil), NSLocalizedString(@"Observe los taxis cercanos a su ubicación", nil),NSLocalizedString(@"Conozco el momento exacto en que el taxista arribo a su ubicacion", nil),NSLocalizedString(@"Califique el servicio recibido por el taxista", nil)];
    _pageImages = @[NSLocalizedString(@"Page1.png", nil),NSLocalizedString(@"Page2.png", nil), NSLocalizedString(@"Page3.png", nil), NSLocalizedString(@"Page4.png", nil)];
    _stepTexts = @[NSLocalizedString(@"Paso 1", nil),NSLocalizedString(@"Paso 2", nil),NSLocalizedString(@"Paso 3", nil),NSLocalizedString(@"Paso 4", nil)];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ESPageHelpViewController"];
    self.pageViewController.dataSource = self;
    
    ESContentHelpViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkthrough:(id)sender {
    ESContentHelpViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

- (ESContentHelpViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ESContentHelpViewController *ESContentHelpViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ESContentHelpViewController"];
    ESContentHelpViewController.imageFile = self.pageImages[index];
    ESContentHelpViewController.titleText = self.pageTitles[index];
    ESContentHelpViewController.stepText = self.stepTexts[index];
    ESContentHelpViewController.pageIndex = index;
    
    return ESContentHelpViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ESContentHelpViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ESContentHelpViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(goToNextViewController) userInfo:nil repeats:NO];
        
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (void) goToNextViewController {
    [self performSegueWithIdentifier:@"helpToMenu" sender:self];
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //ESRootTaxiRequestViewController *mapVC = segue.destinationViewController;

}
@end
