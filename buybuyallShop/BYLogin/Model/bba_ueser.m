//
//  bba_ueser.m
//  buybuyallShop
//
//  Created by buybuyall on 15/7/22.
//  Copyright (c) 2015年 VilsonLee. All rights reserved.
//

#import "bba_ueser.h"

@implementation bba_ueser
@synthesize username, password;

-(id) init
{
    self = [super init];
    if (self)
    {
        self._url = @"login";
    }
    return self;
}

@end
