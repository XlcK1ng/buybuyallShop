//
//  UIAlertView+UIAlertViewExtract.m
//  buybuyallShop
//
//  Created by buybuyall on 15/7/22.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import "UIAlertView+UIAlertViewExtract.h"
#import <UIKit/UIKit.h>

@implementation UIAlertView (UIAlertViewExtract)

+(void) quickDisplay: (NSString *)message;
{
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"错误"// NSLocalizedString(@"Error", nil)
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle: @"退出" //  NSLocalizedString(@"Exit", nil)
                                              otherButtonTitles:nil, nil] ;
    [alertView show];
    
}

+(void) quickMessage: (NSString *)message;
{
    
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" //  NSLocalizedString(@"message", nil)
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"退出" //  NSLocalizedString(@"Exit", nil)
                                              otherButtonTitles:nil, nil] ;
    [alertView show];
    
}

+(void) quickAlertWithTitle: (NSString*) title messageTitle: (NSString *) message  dismissTitle:(NSString *) btn;
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message												   
                                                       delegate:nil
                                              cancelButtonTitle:btn
                                              otherButtonTitles:nil, nil];
    [alertView show];
}




@end
