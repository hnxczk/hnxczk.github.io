//
//  Whip.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Whip.h"

@implementation Whip

- (instancetype)initWithBeverage:(Beverage *)beverage
{
    if (self = [super init]) {
        _beverage = beverage;
    }
    return self;
}

- (NSString *)getDescript
{
    return [NSString stringWithFormat:@"%@, Whip", [self.beverage getDescript]];
}

- (CGFloat)cost
{
    return .10 + [self.beverage cost];
}

@end
