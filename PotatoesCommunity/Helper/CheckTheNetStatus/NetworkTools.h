//
//  NetworkTools.h
//  DetectTheNetWork
//
//  Created by 费城 on 2020/1/14.
//  Copyright © 2020 BUG-Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTools : NSObject

+ (NSString *)systemGetNetworkType;

- (void)AfnGetNetworkStates;

@end

NS_ASSUME_NONNULL_END
