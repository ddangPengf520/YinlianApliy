//
//  DdNetWork.m
//  YinLian
//
//  Created by dpfst520 on 15/12/1.
//  Copyright © 2015年 pengfei.dang. All rights reserved.
//

#import "DdNetWork.h"

#import "Reachability.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation DdNetWork





//get请求
+ (void)getRequestWithURLString:(NSString *)urlString//url
                     Parameters:(id)parameters//参数
                    RequestHead:(NSDictionary *)requestHead//请求头
                 DataReturnType:(DataReturnType)dataReturnType//请求数据类型
                   SuccessBlock:(void (^)(NSData *data))successBlock//请求成功回调
                   FailureBlock:(void (^)(NSData *error))failureBlock//请求失败回调
{
    if ([self isNetWorkConnectionAvailable]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //
        manager.securityPolicy.allowInvalidCertificates = YES;
        
        //
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        //网络数据形式
        switch (dataReturnType) {
            case DataReturnTypeData:{
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            }
                break;
            case DataReturnTypeJson:{
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
            }
                break;
            case DataReturnTypeXml:{
                manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            }
                
            default:
                break;
        }
        //响应数据支持的类型
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil]];
        
        //url转码
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        //
        if (requestHead) {
            for (NSString *key in requestHead) {
                [manager.requestSerializer setValue:[requestHead objectForKey:key] forHTTPHeaderField:key];
            }
        }
        //请求数据
        [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            successBlock(operation.responseData);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error ----> %@",error);
        }];
    } else {
        NSLog(@"无网络。。。");
    }
}

//post请求
+ (void)postRequestWithURLString:(NSString *)urlString//url
                      Parameters:(id)parameters//参数
                     RequestHead:(NSDictionary *)requestHead//请求头
                  DataReturnType:(DataReturnType) dataReturnType//请求数据类型
                 RequestBodyType:(RequstBodyType)requestBodyType//请求body类型
                    SuccessBlock:(void (^)(NSData *data))successBlock//请求成功回调
                    FailureBlock:(void (^)(NSError *error))failureBlock//请求失败回调
{
    if ([self isNetWorkConnectionAvailable]) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //
        manager.securityPolicy.allowInvalidCertificates = YES;
        
        //
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        //上传数据时候Body类型
        switch (requestBodyType) {
            case RequstBodyTypeString:
                [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
                    return parameters;
                }];
                break;
            case RequstBodyTypeDictionaryToString:
                break;
            case RequstBodyTypeJson:
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
            case RequstBodyTypeXml:
                manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
                
            default:
                break;
        }
        
        //网络数据形式
        switch (dataReturnType) {
            case DataReturnTypeData:
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
            case DataReturnTypeJson:
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                break;
            case DataReturnTypeXml:
                manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
                break;
            default:
                break;
        }
        
        //响应数据类型
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil]];
        
        //url转码
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        //如果有请求头,添加请求头
        if (requestHead) {
            for (NSString *key in requestHead) {
                [manager.requestSerializer setValue:[requestHead objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        //请求数据
        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            successBlock(operation.responseData);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error ---> %@", error);
        }];
    } else {
        NSLog(@"无网络。。。");
    }
}



+ (BOOL)isNetWorkConnectionAvailable
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"NotReachable");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            NSLog(@"WWAn");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            NSLog(@"wifi");
            break;
            
        default:
            break;
    }
    return isExistenceNetwork;
}


@end
