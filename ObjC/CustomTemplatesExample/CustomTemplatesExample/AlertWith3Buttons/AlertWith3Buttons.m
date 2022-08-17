//
//  AlertWith3Buttons.m
//  CustomTemplatesExample
//
//  Created by Leanplum on 9.04.20.
//  Copyright © 2022 Leanplum. All rights reserved.
//

#import "AlertWith3Buttons.h"
#import "UIKit/UIKit.h"
#import <Leanplum/LPActionContext.h>

@implementation AlertWith3Buttons

#pragma mark - Arguments
static NSString *const Name = @"3-button Alert";
static NSString *const TitleArg = @"Title";
static NSString *const MessageArg = @"Message";
static NSString *const LaterArg = @"Ask Me Later";

static NSString *const AcceptActionArg = @"Accept action";
static NSString *const CancelActionArg = @"Cancel action";
static NSString *const LaterActionArg = @"Ask Me Later action";

static NSString *const AcceptStr = @"Accept";
static NSString *const CancelStr = @"Cancel";

static NSString *const TitleVal = @"My title";
static NSString *const MessageVal = @"My default message";
static NSString *const LaterVal = @"Ask Me Later";

#pragma mark - Definition
+ (void)defineAction {
    __block UIViewController *alertController;
    
    //#### example Define message responder, executed when the message is shown
    BOOL (^presentHandler)(LPActionContext *) = ^(LPActionContext *context) {
        //#### example Message files are missing, skip
        if ([context hasMissingFiles]) {
            return NO;
        }
        @try {
            //#### example Present the in-app message in the desired way
            //#### example Dispalying simple Alert view with 3 buttons over top view controller
            UIViewController *topController = [self topViewController];
            
            alertController = [AlertWith3Buttons viewControllerWithContext:context];
            
            [topController presentViewController:alertController animated:YES completion:nil];
            return YES;
        }
        @catch (NSException *exception) {
            //#### example Log exception
            NSLog(@"Exception in message template %@: %@", Name, [exception callStackSymbols]);
            return NO;
        }
    };
    
    BOOL (^dismissHandler)(LPActionContext *) = ^(LPActionContext *context) {
        if (alertController) {
            [alertController dismissViewControllerAnimated:YES completion:^{
                [context actionDismissed];
            }];
            return YES;
        }
        return NO;
    };
    
    [Leanplum defineAction:Name
                    ofKind: kLeanplumActionKindMessage | kLeanplumActionKindAction
     //#### example Define the arguments for the template, configurable from the Dashboard
             withArguments:@[
        [LPActionArg argNamed:TitleArg withString:TitleVal],
        [LPActionArg argNamed:MessageArg withString:MessageVal],
        [LPActionArg argNamed:AcceptStr withString:AcceptStr],
        [LPActionArg argNamed:CancelStr withString:CancelStr],
        [LPActionArg argNamed:LaterArg withString:LaterVal],
        [LPActionArg argNamed:AcceptActionArg withAction:nil],
        [LPActionArg argNamed:CancelActionArg withAction:nil],
        [LPActionArg argNamed:LaterActionArg withAction:nil],
    ]
               withOptions:@{}
            presentHandler:presentHandler
            dismissHandler:dismissHandler];
}

#pragma mark - Presentation
+ (UIViewController *)viewControllerWithContext:(LPActionContext *)context {
    //#### example Extract values from the message context using the argument names defined
    //#### example The values in the context are those defined in the Dashboard or default values
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString([context stringNamed:TitleArg], nil) message:NSLocalizedString([context stringNamed:MessageArg], nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString([context stringNamed:CancelStr], nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //#### Executes the Cancel action, does not track an event
        [context runActionNamed:CancelActionArg];
    }];
    [alert addAction:cancel];
    UIAlertAction *accept = [UIAlertAction actionWithTitle:NSLocalizedString([context stringNamed:AcceptStr], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //#### Executes the Accept action and tracks the event
        [context runTrackedActionNamed: AcceptActionArg];
    }];
    [alert addAction:accept];
    UIAlertAction *maybe = [UIAlertAction actionWithTitle:NSLocalizedString([context stringNamed:LaterVal], nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //#### Executes the Maybe action and tracks the event
        [context runTrackedActionNamed: LaterActionArg];
    }];
    [alert addAction:maybe];
    return alert;
}

+ (UIViewController *)topViewController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}
@end
