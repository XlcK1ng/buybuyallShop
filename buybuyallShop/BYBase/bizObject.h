//
//  bizObject.h
//  buybuyallShop
//
//  Created by buybuyall on 15/7/22.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//
//  buybuyallShiop

//  初步封装的bba-shop的网络请求基类



#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIAlertView+UIAlertViewExtract.h"
#import "NSObject+PropertyArray.h"


@protocol bizEvent <NSObject>//请求后得到的数据的回调代理协议

//请求提交前处理
-(void) didBeforePost: (id) object url: (NSString*) url;

//请求提交后处理
-(void) didAfterPost: (NSString*)  url  dict: (NSDictionary *)  bizObj;

//报错处理
-(void) didPostError: (NSString*) url error: (NSError *)error;


@end



@interface bizObject : NSObject


@property (retain) id <bizEvent> delegate;// 代理协议属性
@property(nonatomic,strong)NSString* _url;//请求路径



-(id)initWithUrl:(NSString*)url;//请求路径的初始化方法
-(void)post;//请求方法
-(void)postData:(NSDictionary*)data;//带参请求方法












@end
