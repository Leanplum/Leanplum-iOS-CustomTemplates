//
//  SliderMessageTemplate.m
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SliderMessageTemplate.h"
#import "SliderViewController.h"

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
    BOOL (^messageResponder)(LPActionContext *) = ^(LPActionContext *context) {
        return [SliderMessageTemplate handleAction:context];
    };
    
    NSArray *titles = @[@"Personalize every message", @"Mobile App & Website Inbox Messages"];
    NSString *keyFormat = @"Title %d";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < titles.count; i++) {
        NSString *key = [NSString stringWithFormat:keyFormat, i + 1];
        dict[key] = titles[i];
    }
    
    [Leanplum defineAction:Name
                    ofKind:kLeanplumActionKindMessage
             withArguments:@[
                 [LPActionArg argNamed:TitleColorArg withColor:UIColor.blackColor],
                 [LPActionArg argNamed:TitlesArg withDict:dict],
                 [LPActionArg argNamed:ImagesArg withDict:@{}]]
             withResponder:messageResponder];
}

+ (BOOL) handleAction:(LPActionContext *)context {
    @try {
        UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        [topController presentViewController:[SliderMessageTemplate viewControllerWithContext:context] animated:YES completion:nil];
        return YES;
    }
    @catch (NSException *exception) {
        return NO;
    }
}

#pragma mark - Presentation
+ (UIViewController *)viewControllerWithContext:(LPActionContext *)context
{
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

+ (NSArray *) sortValuesByKeys:(NSDictionary *)dict {
    NSArray *sortedKeys = [[dict allKeys] sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    NSArray *objects = [dict objectsForKeys: sortedKeys notFoundMarker: [NSNull null]];
    
    return objects;
}

@end
