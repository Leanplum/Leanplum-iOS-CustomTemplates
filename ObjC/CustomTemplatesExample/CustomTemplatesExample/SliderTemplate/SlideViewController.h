//
//  PageViewController.h
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlideViewController : UIViewController

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageName;
@property UIColor *titleColor;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
