//
//  NSObject+NSObject_PropertyArray.m
//  buybuyallShop
//
//  Created by buybuyall on 15/7/21.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import "NSObject+PropertyArray.h"

@implementation NSObject (PropertyArray)

- (NSArray *) allKeys {
    
    Class clazz = [self class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray array];
    for (int i = 0; i < count ; i++) {
        
        //判断数据类型
        //目前仅支持NSInteger, NSString, long, NSNumber，NSArray这几种
        
    
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
    }
    
    
    free(properties);
    
    
    //如果继承自bizClas,则不需要把bizClas的几个属性给取出来
    
    Class superClass = class_getSuperclass([self class]);
    if (superClass != [NSObject class]) {
        
        //得到类名称
        NSString *className = [NSStringFromClass([superClass class]) lowercaseString];
        if (![className isEqualToString:@"bizclas"])
        {
        
            properties = class_copyPropertyList(superClass, &count);
            for (int i = 0; i < count ; i++) {
                
                //
                
                
                const char* propertyName = property_getName(properties[i]);
                [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    return [NSArray arrayWithArray:propertyArray];
}

 - (NSDictionary *) allValues
{
    Class clazz = [self class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    
    NSMutableArray* propertyArray = [NSMutableArray array];
    for (int i = 0; i < count ; i++) {
        
        //判断数据类型
        //目前仅支持NSInteger, NSString, long, NSNumber，NSArray这几种
        const char* propertyName = property_getName(properties[i]);
        
        id value =  [self performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value != nil)
           [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    
    //如果继承自bizClas,则不需要把bizClas的几个属性给取出来
    
    Class superClass = class_getSuperclass([self class]);
    if (superClass != [NSObject class]) {
        
        //得到类名称
        NSString *className = [NSStringFromClass([superClass class]) lowercaseString];
        if (![className isEqualToString:@"bizobject"])
        {
            
            properties = class_copyPropertyList(superClass, &count);
            for (int i = 0; i < count ; i++) {
                
                const char* propertyName = property_getName(properties[i]);
                
                id value =  [self performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
                if(value != nil)
                    [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];

                
                
               // [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
            }
        }
    }
    
    return [self dictionaryWithValuesForKeys:propertyArray];
}

@end
