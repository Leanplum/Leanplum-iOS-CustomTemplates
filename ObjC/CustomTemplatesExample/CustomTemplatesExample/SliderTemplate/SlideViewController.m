//
//  PageViewController.m
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import "SlideViewController.h"
#import "LPFileManager.h"

@interface SlideViewController ()

@end

@implementation SlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self titleLabel] setText:self.titleText];
    [[self titleLabel] setTextColor:self.titleColor];

    if (self.imageName){
        // Try to download the image
        BOOL willDownload = [LPFileManager maybeDownloadFile:self.imageName defaultValue:nil onComplete:^{
            [self setImageToView];
        }];
        
        // If the image is already downloaded it will not trigger the onComplete callback
        if (!willDownload) {
            [self setImageToView];
        }
    }
}

- (void)setImageToView {
    UIImage *img = [self getImageFile:self.imageName];
    [self.imageView setImage:img];
}

/**
 * Get the image from the file system
 */
- (UIImage*)getImageFile:(NSString*)fileName {
    NSString *fileValue = [LPFileManager fileValue:fileName withDefaultValue:fileName];
    if (fileValue) {
        UIImage *img = [UIImage imageWithContentsOfFile:fileValue];
        return img;
    }
    return nil;
}
@end
