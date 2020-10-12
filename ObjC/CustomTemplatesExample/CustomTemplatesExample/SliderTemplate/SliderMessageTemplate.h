//
//  SliderMessageTemplate.h
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 27.09.20.
//  Copyright © 2020 Nikola Zagorchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Leanplum.h"

NS_ASSUME_NONNULL_BEGIN

@interface SliderMessageTemplate : NSObject
+ (void)defineAction;
+ (BOOL)handleAction:(LPActionContext *)context;
@end

NS_ASSUME_NONNULL_END
