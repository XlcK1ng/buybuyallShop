//
//  ImageDownloader.h
//  buybuyallShop
//
//  Created by buybuyall on 15/7/23.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "ImageItem.h"


@class ImageItem;


@interface ImageDownloader : NSObject


@property (nonatomic,copy) NSString * imageUrl;
@property (nonatomic,retain) ImageItem * imageItem;


//图像下载完成后，使用bloack回调
@property (nonatomic,copy) void (^completionHandler)(void);


//开始下载图像
- (void)startDownloadImage:(NSString *)imageUrl;


//从本地加载图像
- (UIImage *)loadLocalImage:(NSString *)imageUrl;


@end
