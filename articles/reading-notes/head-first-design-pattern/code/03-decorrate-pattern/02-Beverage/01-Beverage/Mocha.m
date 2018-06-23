//
//  Mocha.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Mocha.h"

@implementation Mocha

- (instancetype)initWithBeverage:(Beverage *)beverage
{
    if (self = [super init]) {
        _beverage = beverage;
    }
    return self;
}

- (NSString *)getDescript
{
    return [NSString stringWithFormat:@"%@, Mocha", [self.beverage getDescript]];
}

- (CGFloat)cost
{
    return .20 + [super cost] + [self.beverage cost];
}

@end
