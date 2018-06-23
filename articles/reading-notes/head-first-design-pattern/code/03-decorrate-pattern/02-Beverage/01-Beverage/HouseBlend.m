//
//  HouseBlend.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "HouseBlend.h"

@implementation HouseBlend

- (instancetype)init
{
    if (self = [super init]) {
        self.descript = @"House Blend Coffee";
    }
    return self;
}

- (CGFloat)cost
{
    return 0.89;
}

@end
