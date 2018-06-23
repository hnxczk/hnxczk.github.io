//
//  Soy.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Soy.h"

@implementation Soy

- (instancetype)initWithBeverage:(Beverage *)beverage
{
    if (self = [super init]) {
        _beverage = beverage;
    }
    return self;
}

- (NSString *)getDescript
{
    return [NSString stringWithFormat:@"%@, Soy", [self.beverage getDescript]];
}

- (CGFloat)cost
{
    return .15 + [super cost] + [self.beverage cost];
}

@end
