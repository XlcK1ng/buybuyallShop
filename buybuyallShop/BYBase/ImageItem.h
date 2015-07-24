//
//  ImageItem.h
//  buybuyallShop
//
//  Created by buybuyall on 15/7/23.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageItem : NSObject
@property (nonatomic,copy) NSString * newsTitle;
@property (nonatomic,copy) NSString * newsPicUrl;
@property (nonatomic,retain) UIImage * newsPic;
@end
