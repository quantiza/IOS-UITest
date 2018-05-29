//
//  URLSessionController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/5/28.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "URLSessionController.h"

@interface URLSessionController () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation URLSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"URLSession Demo";
    self.view.backgroundColor = WHITE_COLOR;
//    [self sendRequest];
//    [self loadData];
//    [self loadImage];
    [self uploadData];
}

- (void)loadData {
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                         NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                                                                     }];
    [downloadTask resume];
}

- (void)loadImage {
    NSURL *url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/7/7f/Williams_River-27527.jpg"];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url
                                                                                  completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                                      UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                                                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                                                          self.imageView.image = image;
                                                                                      });
                                                                                  }];
    [downloadPhotoTask resume];
}

- (void)uploadData {
    NSURL *url = [NSURL URLWithString:@"http://www.pgyer.com/apiv1/user/listMyPublished"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *dictionary = @{@"uKey":@"a6657cf2988d2718c81530c265d40bd1", @"_api_key":@"f6543814cef5d43eb9346f17bc24ddc4", @"page":@1};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    
    
    if (!error) {
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                   fromData:data
                                                          completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                              NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
                                                          }];
        [uploadTask resume];
    }
}

- (void)sendRequest {
    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置request的缓存策略（决定该request是否要从缓存中获取）
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:nil];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"接收响应");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"接收到数据");
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"请求完成或者是失败");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler {
    completionHandler(proposedResponse);
}

@end
