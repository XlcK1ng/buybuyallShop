//
//  NSObject+NSObject_PropertyArray.h
//  buybuyallShop
//
//  Created by buybuyall on 15/7/21.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (PropertyArray)
    - (NSArray *) allKeys;
    - (NSDictionary *) allValues;

@end
