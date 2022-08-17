//
//  LPAdsTrackingActionTemplate.h
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 2.10.20.
//  Copyright © 2022 Leanplum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Leanplum/LPActionContext.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPAdsTrackingActionTemplate : NSObject

+ (void)defineAction;
@property (nonatomic, strong) LPActionContext *context;

@end

NS_ASSUME_NONNULL_END
