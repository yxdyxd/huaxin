//
//  NetWorkRequest.m
//  Lesson项目A_豆瓣
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "NetWorkRequest.h"
//#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"
#import "NSString+AES.h"
#import "NonNetWorkViewController.h"

@implementation NetWorkRequest

// GET请求
-(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)parameterDic successResponse:(SuccessResponse)success failureResponse:(FailureResponse)fail{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.securityPolicy.validatesDomainName=NO;
    manager.securityPolicy.allowInvalidCertificates=YES;
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:url parameters:parameterDic headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

// POST请求
-(void)sendDataWithUrl:(NSString *)url paramters:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failure:(FailureResponse)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:url parameters:paramterDic headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/// post请求（form-data请求）
- (void)postSendDataWithUrl:(NSString *)url paramter:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failureRespone:(FailureResponse)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 100;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html",@"application/json", @"text/json" ,@"text/javascript", nil];;
    [manager POST:url parameters:paramterDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[@"Data" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"DataName"
                                fileName:@"DataFileName"
                                mimeType:@"data"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        success(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"视频请求失败：%@", error);
        failure(error);
    }];

    
}

// post加密（发送的dict，AES加密）
- (void)sendEnscriptUrl:(NSString *)url paramter:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failureRespone:(FailureResponse)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //这里就是对加密方法返回出去的加密string做data转换操作
    //    NSString *scrStr = [NSString stringWithFormat:@"%@", paramterDic];
    
    NSString *scrStr = [self ObjectTojsonString:paramterDic];
    
    [self dictionaryToJson:paramterDic];
    NSData * data=[[scrStr aci_encryptWithAES] dataUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [@"61D276771CBDC1C06B40CD04CA243462FD87657FDD1CED557ADB8D9B23994E2603ECE0F5405BF63E926ADBFB8283E05E" dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    // 此处设置请求体 (即将参数加密后的字符串,转为data)一般是参数字典转json字符串,再将json字符串加密,最后将加密后的字符串转为data 设置为请求体
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:data];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSURLSessionDataTask * tesk = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSDictionary *dict = @{@"localState":@"Success"};
        if (responseObject != nil) {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        }
        
        
        if (error) {
            
            failure(error);
            
        }else{
            
            success(dict);
        }
    }];
    [tesk resume];
    
}

/// post请求json字符串形式
- (void)postJsonStringWithUrl:(NSString *)url paramter:(NSDictionary *)paramterDic successResponse:(SuccessResponse)success failureRespone:(FailureResponse)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //这里就是对加密方法返回出去的加密string做data转换操作
    //    NSString *scrStr = [NSString stringWithFormat:@"%@", paramterDic];
    
    NSString *scrStr = [self ObjectTojsonString:paramterDic];
    
    [self dictionaryToJson:paramterDic];
    NSData * data=[scrStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    // 此处设置请求体 (即将参数加密后的字符串,转为data)一般是参数字典转json字符串,再将json字符串加密,最后将加密后的字符串转为data 设置为请求体
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:data];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSURLSessionDataTask * tesk = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
        if (error) {
            
            failure(error);
            
        }else{
            
            success(dict);
        }
    }];
    [tesk resume];
}

- (NSData *)NSDictionaryToNSData:(NSDictionary *)dictionary
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictionary forKey:@"KeyValue"];
    [archiver finishEncoding];
    
    return data;
}

//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//数据转成JsonString类型（去除空格）
-(NSString*)ObjectTojsonString:(id)object

{
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        NSLog(@"error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    
    return mutStr;
}

@end
