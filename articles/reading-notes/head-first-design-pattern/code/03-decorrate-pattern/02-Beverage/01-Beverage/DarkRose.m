//
//  DarkRose.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "DarkRose.h"

@implementation DarkRose

- (instancetype)init
{
    if (self = [super init]) {
        self.descript = @"Dark Rose Coffee";
    }
    return self;
}

- (CGFloat)cost
{
    return 0.99;
}

@end
