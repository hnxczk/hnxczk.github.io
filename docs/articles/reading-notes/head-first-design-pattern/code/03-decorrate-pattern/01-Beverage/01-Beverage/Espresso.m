//
//  Espresso.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Espresso.h"

@implementation Espresso

- (instancetype)init
{
    if (self = [super init]) {
        _descript = @"Espresso";
    }
    return self;
}

- (CGFloat)cost
{
    return 1.99;
}

@end
