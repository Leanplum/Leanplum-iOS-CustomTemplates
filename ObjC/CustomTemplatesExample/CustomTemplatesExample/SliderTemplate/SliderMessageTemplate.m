//
//  SliderMessageTemplate.m
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2022 Nikola Zagorchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SliderMessageTemplate.h"
#import "SliderViewController.h"
#import <Leanplum/LPActionContext.h>

#pragma mark - Arguments
static NSString *const Name = @"Slider";
static NSString *const TitleColorArg = @"Title Color";
static NSString *const TitlesArg = @"Titles";
static NSString *const ImagesArg = @"Images";

static NSString *const StoryboardName = @"SliderMessageTemplateStoryboard";
static NSString *const SliderViewControllerName = @"SliderViewController";

@implementation SliderMessageTemplate

#pragma mark - Definition
+ (void)defineAction {
    NSArray *titles = @[@"Personalize every message", @"Mobile App & Website Inbox Messages"];
    NSString *keyFormat = @"Title %d";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < titles.count; i++) {
        NSString *key = [NSString stringWithFormat:keyFormat, i + 1];
        dict[key] = titles[i];
    }
    
    __block UIViewController *sliderViewController;
    BOOL (^presentHandler)(LPActionContext *) = ^(LPActionContext *context) {
        @try {
            UIViewController *topController = [self topViewController];
            sliderViewController = [SliderMessageTemplate viewControllerWithContext:context];
            [topController presentViewController:sliderViewController animated:YES completion:nil];
            
            return YES;
        }
        @catch (NSException *exception) {
            return NO;
        }
    };
    
    BOOL (^dismissHandler)(LPActionContext *) = ^(LPActionContext *context) {
        if (sliderViewController) {
            [sliderViewController dismissViewControllerAnimated:YES completion:^{
                [context actionDismissed];
            }];
            return YES;
        }
        return NO;
    };
    
    NSArray *args = @[
        [LPActionArg argNamed:TitleColorArg withColor:UIColor.blackColor],
        [LPActionArg argNamed:TitlesArg withDict:dict],
        [LPActionArg argNamed:ImagesArg withDict:@{}]
    ];
    
    [Leanplum defineAction:Name
                    ofKind:kLeanplumActionKindMessage
             withArguments:args
               withOptions:@{}
            presentHandler:presentHandler
            dismissHandler:dismissHandler];
}

#pragma mark - Presentation
+ (UIViewController *)viewControllerWithContext:(LPActionContext *)context {
    NSBundle *bundle = [NSBundle bundleForClass:[SliderViewController class]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:StoryboardName bundle:bundle];
    SliderViewController *vc = [storyboard instantiateViewControllerWithIdentifier:SliderViewControllerName];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    NSDictionary *dictTitles = [context dictionaryNamed:TitlesArg];
    NSDictionary *dictImages = [context dictionaryNamed:ImagesArg];
    
    vc.slideTitleColor = [context colorNamed:TitleColorArg];
    vc.slideTitles = [self sortValuesByKeys:dictTitles];
    vc.slideImages = [self sortValuesByKeys:dictImages];
    
    return vc;
}

+ (UIViewController *)topViewController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

+ (NSArray *)sortValuesByKeys:(NSDictionary *)dict {
    NSArray *sortedKeys = [[dict allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    NSArray *objects = [dict objectsForKeys: sortedKeys notFoundMarker: [NSNull null]];
    
    return objects;
}

@end
