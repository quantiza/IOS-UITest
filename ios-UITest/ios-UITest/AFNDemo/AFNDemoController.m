//
//  AFNDemoController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/5/31.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "AFNDemoController.h"
#import <AFNetworking.h>

@interface AFNDemoController ()

@end

@implementation AFNDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AFN DEMO";
    self.view.backgroundColor = WHITE_COLOR;
//    [self request01];
//    [self request02];
    [self postDemo1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GET请求
//第一种情况：服务端的响应体的形式是text/json格式
- (void)request01 {
    NSString *urlStr = @"https://api.douban.com/v2/book/1220562";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"fractionCompleted=======%f", downloadProgress.fractionCompleted);
        NSLog(@"completedUnitCount=======%lld", downloadProgress.completedUnitCount);
        NSLog(@"totalUnitCount=======%lld", downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"obj->%@   res:%@", [responseObject class], responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"====failure");
    }];
}

//第二种情况：服务端响应体的content-type: 是text/xml格式
- (void)request02 {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"https://www.baidu.com" parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"Sucess=====%@", responseObject);
         } failure:nil];
}

//get请求中的https 安全认证
- (void)getHttps {
    NSString *https = @"https://www.baidu.com";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //解决https证书问题
    //把服务端证书（需要转成cer格式）放到app项目资源里，AFSecurityPolicy会自动寻找根目录下所有cer文件
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager GET:https parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"success============%@", responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"failure============%@", error);
         }];
}

//AF添加get请求头
- (void)getHTTPHeader {
    NSString *str = @"";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"111111" forHTTPHeaderField:@"app"];
    [manager GET:str parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"success============%@", responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"failure============%@", error);
         }];
}

#pragma mark - POST请求
- (void)postDemo1 {
    NSString *url = @"http://www.pgyer.com/apiv1/user/listMyPublished";
    NSDictionary *para = @{@"uKey":@"a6657cf2988d2718c81530c265d40bd1",
                           @"_api_key":@"f6543814cef5d43eb9346f17bc24ddc4",
                           @"":@1};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    [manager POST:url parameters:para progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"success============%@", responseObject);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"failure============%@", error);
          }];
}

@end























