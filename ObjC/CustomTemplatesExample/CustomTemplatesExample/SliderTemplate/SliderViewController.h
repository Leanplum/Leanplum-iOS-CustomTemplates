//
//  SliderViewController.h
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SliderViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) NSArray *slideTitles;
@property (strong, nonatomic) NSArray *slideImages;
@property (strong, nonatomic) UIColor *slideTitleColor;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
-(void)closeButtonAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
