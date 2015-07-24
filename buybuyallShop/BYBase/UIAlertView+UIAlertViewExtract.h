//
//  UIAlertView+UIAlertViewExtract.h
//  buybuyallShop
//
//  Created by buybuyall on 15/7/22.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIAlertView (UIAlertViewExtract)


+(void) quickDisplay: (NSString *)message;
+(void) quickAlertWithTitle: (NSString*) title messageTitle: (NSString *) message  dismissTitle:(NSString *) btn;
+(void) quickMessage: (NSString *)message;





@end
