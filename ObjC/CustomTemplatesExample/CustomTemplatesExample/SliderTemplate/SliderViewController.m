//
//  SliderViewController.m
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import "SliderViewController.h"
#import "SlideViewController.h"

static NSString *const SlideViewControllerName = @"SlideViewController";
static NSString *const PageViewControllerName = @"PageViewController";

@interface SliderViewController ()
@property (nonatomic) NSUInteger slidesCount;
@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.slidesCount = self.slideTitles.count > self.slideImages.count ? self.slideTitles.count : self.slideImages.count;
    
    [self configureCloseButton];
    [self configurePageControl];
    [self configurePageViewController];
}

- (void)configurePageControl {
    UIPageControl *pageControl = UIPageControl.appearance;
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
    pageControl.currentPageIndicatorTintColor = UIColor.grayColor;
}

- (void)configureCloseButton {
    self.closeBtn.layer.cornerRadius = self.closeBtn.frame.size.height / 2;
    self.closeBtn.clipsToBounds = YES;
    self.closeBtn.backgroundColor = UIColor.lightGrayColor;
    [self.closeBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [self.closeBtn addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)closeButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Page View Controller
- (void)configurePageViewController {
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:PageViewControllerName];
    self.pageViewController.dataSource = self;
    
    SlideViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    //        [self.view addSubview:_pageViewController.view];
    [self.view insertSubview:_pageViewController.view atIndex:0];
    [self.pageViewController didMoveToParentViewController:self];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((SlideViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((SlideViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == self.slidesCount) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (SlideViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ((self.slidesCount == 0) || (index >= self.slidesCount)) {
        return nil;
    }
    
    SlideViewController *singleSlideViewController = [self.storyboard instantiateViewControllerWithIdentifier:SlideViewControllerName];
    if (self.slideTitles.count >= index + 1) {
        singleSlideViewController.titleText = self.slideTitles[index];
    }
    
    if (self.slideImages.count >= index + 1) {
        singleSlideViewController.imageName = self.slideImages[index];
    }
    
    singleSlideViewController.titleColor = self.slideTitleColor;
    singleSlideViewController.pageIndex = index;
    
    return singleSlideViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.slidesCount;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
