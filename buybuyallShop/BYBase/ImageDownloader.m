//
//  ImageDownloader.m
//  buybuyallShop
//
//  Created by buybuyall on 15/7/23.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import "ImageDownloader.h"
#import "ImageItem.h"



@implementation ImageDownloader


- (void)dealloc
{
    self.imageUrl = nil;
}



#pragma mark - 异步下载
- (void)startDownloadImage:(NSString *)imageUrl{
    
    
    self.imageUrl = imageUrl;
    
    // 先判断本地沙盒是否已经存在图像，存在直接获取，不存则下载，下载后保存在沙盒的Caches的子文件夹DownloadImages中
    UIImage * image = [self loadLocalImage:imageUrl];
    
    if (image == nil)
    {
        
        //GCD的多线程管理，异步下载
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            // 缓存图片
            [imageData writeToFile:[self imageFilePath:imageUrl] atomically:YES];
            
            
            //回到主线程完成UI设置
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                //将下载的图像，存入newsItem对象中
                UIImage * image = [UIImage imageWithData:imageData];
                self.imageItem.newsPic = image;
                
                //使用block实现回调，通知图像下载完成
                if (self.completionHandler) {
                    self.completionHandler();
                }

            });
        
        });

    }

}



#pragma mark - 加载本地图像

- (UIImage *)loadLocalImage:(NSString *)imageUrl
{
    
    self.imageUrl = imageUrl;
    
    // 获取图像路径
    NSString * filePath = [self imageFilePath:self.imageUrl];
    
    UIImage * image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image != nil) {
        return image;
    }
    
    return nil;
}




#pragma mark - 获取图片路径
-(NSString*)imageFilePath:(NSString*)imageUrl{
    
    //获取caches文件夹路劲
    NSString* cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //创建下载图片后的文件夹 并生成路径
    NSString* downloadImagesPath = [cachesPath stringByAppendingPathComponent:@"DownloadImages"];
    
    NSFileManager* fileManager  = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:downloadImagesPath]) {//如果路径不存在  写入路径
        
        [fileManager createDirectoryAtPath:downloadImagesPath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    
    //拼接图像文件在沙盒中的路径,因为图像URL有"/",要在存入前替换掉,随意用"_"代替
    NSString * imageName = [imageUrl stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString * imageFilePath = [downloadImagesPath stringByAppendingPathComponent:imageName];
    
    
    return imageFilePath;

}




@end
