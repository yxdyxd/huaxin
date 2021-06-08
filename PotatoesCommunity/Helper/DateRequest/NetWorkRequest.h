//
//  NetWorkRequest.h
//  Lesson项目A_豆瓣
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SuccessResponse)(NSDictionary *dic);
typedef void(^FailureResponse)(NSError *error);

@interface NetWorkRequest : NSObject

/// get请求
-(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameterDic successResponse:(SuccessResponse)success failureResponse:(FailureResponse)fail;

/// post请求
-(void)sendDataWithUrl:(NSString *)url paramters:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failure:(FailureResponse)failure;

/// post加密（发送的dict，AES加密）
- (void)sendEnscriptUrl:(NSString *)url paramter:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failureRespone:(FailureResponse)failure;

/// post请求（form-data请求）
- (void)postSendDataWithUrl:(NSString *)url paramter:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failureRespone:(FailureResponse)failure;

/// post请求json字符串形式
- (void)postJsonStringWithUrl:(NSString *)url paramter:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failureRespone:(FailureResponse)failure;

@end
