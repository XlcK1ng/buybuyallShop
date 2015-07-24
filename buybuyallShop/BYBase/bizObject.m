//
//  bizObject.m
//  buybuyallShop
//
//  Created by buybuyall on 15/7/22.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import "bizObject.h"

@implementation bizObject
@synthesize delegate, _url;//, _showBlockFlag;

-(id) initWithUrl:(NSString *)url
{
    
    
    self = [super init];
    if (self) {
        _url = url;
    }
    
    return self;
}


//ios5中apple增加了解析JSON的api——NSJSONSerialization
//NSJSONSerialization在效率上完胜SBJSON、TouchJSON、YAJL、JSONKit、NextiveJson



#pragma mark - 解析数据私有方法 通过代理回调请求页进行处理
-(void) parseJsonData:(NSData *)data{
    
    NSError* error;
    NSDictionary* json =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    //数据为空时候，处理空数据
    if (json == nil)
    {
        
        if (nil != delegate)
        {
        SEL didPostErrorSelector = @selector(didPostError:error:);
            
            if ([delegate respondsToSelector:didPostErrorSelector])
            {
                
            [delegate didPostError:_url error:error];
            
            }
            else
                [UIAlertView quickDisplay:error.description];

        }
        return;
    }
    
    
    //捕获异常或报错 显示报错
    if ([json objectForKey:@"tip"])
    {
        [UIAlertView quickDisplay: [json objectForKey:@"tip"]];
        [delegate didAfterPost: _url dict: json];
        return;
    }
    
    if (nil != delegate)
        if ([delegate respondsToSelector:@selector(didAfterPost:dict:)])
        {
            [delegate didAfterPost: _url dict: json];
        }
    
}


#pragma mark - 带参数请求
-(void)postData: (NSDictionary *) data{
    
    //操作前处理
    if (nil != delegate)
    {
        if ([delegate respondsToSelector:@selector(didBeforePost:url:)])
        {
            //[parentCtrl didSelectExp: (NSDictionary *)[exps objectAtIndex: rowIndex]];
            [delegate didBeforePost: self url: _url];
        }
    }
    
    //性能测试
    /*
     NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
     NSTimeInterval a=[dat timeIntervalSince1970] * 1000;
     NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
     */
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",
                        @"http://192.168.1.175:8080/",
                        _url];
    
    NSURL *URL = [NSURL URLWithString: strUrl];
    
    NSLog(@"path=%@", strUrl);
    
    SEL didPostErrorSelector = @selector(didPostError:error:);
    
    
    AFHTTPRequestOperationManager* AF_manager = [AFHTTPRequestOperationManager manager];
    AF_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestSerializer* httpRequest  = [AFHTTPRequestSerializer serializer];
    AF_manager.requestSerializer = httpRequest;
    
    
    //把当前对象转成NSDirectory
    //NSDictionary *objDict = [self allValues];
    
     NSLog(@"data=%@", data);
    
    
    [AF_manager POST:[URL absoluteString] parameters:data
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 //    [_block hideBlockView];
                 
                 //NSLog(@"str = %@", result);
                 [self parseJsonData: (NSData *)responseObject];
                 
                 
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 // 解析失败后的处理
                 //NSLog(@"error:++++%@",error.localizedDescription);
                 //if (_needBlock)
                 //    [_block hideBlockView];
                 
                 if (nil != delegate)
                 {
                     //NSLog(@"%@", [NSStringFromClass([doEvent class]) lowercaseString]);
                     if ([delegate respondsToSelector: didPostErrorSelector])
                     {
                         [delegate didPostError:_url error:error];
                     }
                     else {
                         
                         //[UIApplication sharedApplication].keyWindow
                         //[UIApplication sharedApplication].keyWindow
                         [UIAlertView quickDisplay: @"获取数据失败，请检查网络连接"];
                     }
                 }

                 
             }];

}

#pragma mark - 不带参数请求
-(void)post
{
    
    NSDictionary *objDict = [self allValues];
    [self postData: objDict];
    
    
}








@end
