//
//  ViewController.m
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 12.06.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import "ViewController.h"
#import "SliderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSBundle *bundle = [NSBundle bundleForClass:[SliderViewController class]];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SliderMessageTemplateStoryboard" bundle:bundle];
//    SliderViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SliderViewController"];
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];
}
@end
