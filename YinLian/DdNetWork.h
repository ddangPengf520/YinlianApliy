//
//  DdNetWork.h
//  YinLian
//
//  Created by dpfst520 on 15/12/1.
//  Copyright © 2015年 pengfei.dang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DataReturnType) {
    DataReturnTypeData, // 返回Data数据
    DataReturnTypeXml,  // 返回XML数据
    DataReturnTypeJson  // 返回Json数据
};

typedef NS_ENUM(NSInteger, RequstBodyType) {
    RequstBodyTypeXml,  // XML格式
    RequstBodyTypeJson, // JSon格式
    RequstBodyTypeDictionaryToString, // 字典转字符串
    RequstBodyTypeString // 字符串
};

@interface DdNetWork : NSObject

//get请求
+ (void)getRequestWithURLString:(NSString *)urlString//url
                     Parameters:(id)parameters//参数
                    RequestHead:(NSDictionary *)requestHead//请求头
                 DataReturnType:(DataReturnType)dataReturnType//请求数据类型
                   SuccessBlock:(void (^)(NSData *data))successBlock//请求成功回调
                   FailureBlock:(void (^)(NSData *error))failureBlock;//请求失败回调
//post请求
+ (void)postRequestWithURLString:(NSString *)urlString//url
                      Parameters:(id)parameters//参数
                     RequestHead:(NSDictionary *)requestHead//请求头
                  DataReturnType:(DataReturnType) dataReturnType//请求数据类型
                 RequestBodyType:(RequstBodyType)requestBodyType//请求body类型
                    SuccessBlock:(void (^)(NSData *data))successBlock//请求成功回调
                    FailureBlock:(void (^)(NSError *error))failureBlock;//请求失败回调

//判断网络
+ (BOOL)isNetWorkConnectionAvailable;














@end
