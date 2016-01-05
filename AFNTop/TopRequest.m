//
//  TopRequest.m
//  AFNTop
//
//  Created by Haonan on 16/1/4.
//  Copyright © 2016年 Haonan. All rights reserved.
//

#import "TopRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "Utils.h"

@implementation TopRequest

static TopRequest *instance = nil;
static dispatch_once_t onceToken;

+ (TopRequest *)sharedTopRequest {
    dispatch_once(&onceToken, ^{
        if(instance == nil) {
            instance = [[super allocWithZone:NULL]init];
        }
    });
    return instance;
}

+ (BOOL)execute:(NSString*) uri params:(NSDictionary *)params  callback:(REQUEST_CALLBACK)callback {
    NSLog(@"%@", uri);
    TopRequest* jr = [self sharedTopRequest];
    return [jr _execute:uri params:params callback:callback];
}

- (BOOL)_execute:(NSString*) uri params:(NSDictionary *)params  callback:(REQUEST_CALLBACK)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    if (![self beforeExecute:manager]) {
        return false;
    };
    
    [manager GET:uri parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ResponseBody *response = [[ResponseBody alloc]init];
        // 返回数据
        response.text = operation.responseString;
        NSLog(@"%@", response.text);
        // 返回数据处理
        NSDictionary *responseDic = [Utils dictionaryWithJsonString:response.text];
        response.msg = responseDic[@"msg"];
        response.data = responseDic[@"data"];
        response.code = responseDic[@"code"];
        response.error = nil;
        NSLog(@"DATA: %@", response.data);
        
        if(callback != nil)
            callback(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 返回数据处理
        ResponseBody *response = [[ResponseBody alloc]init];
        response.error = error;
        response.text = operation.responseString;
        response.code = [[NSNumber alloc]initWithInt:-1];
        response.data = @"出错了";
        [self afterExecute:response];
        callback(response);
    }];
    return true;
}

// 检查网络状况，可以放在全局来做，详见NetStatusMonitor
- (BOOL)beforeExecute:(AFHTTPRequestOperationManager*)manager {
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [manager.reachabilityManager startMonitoring];
    return true;
}

// 网络状况报错，可以自定义alert
- (BOOL) afterExecute:(ResponseBody *) response {
    
    if (response.error == nil) {
        return TRUE;
    }
    
    if ([response.error code] == NSURLErrorNotConnectedToInternet) {
        NSLog(@"网络不给力");
        return FALSE;
    }
    
    NSLog(@"server error text is: %@", response.error.localizedDescription);
    NSLog(@"服务器故障，请稍后再试。");
    
    return true;
}


@end
