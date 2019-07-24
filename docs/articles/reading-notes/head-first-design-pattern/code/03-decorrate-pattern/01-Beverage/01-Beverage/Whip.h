//
//  Whip.h
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "CondimentDecorator.h"

@interface Whip : CondimentDecorator

@property (nonatomic, strong) Beverage *beverage;

- (instancetype)initWithBeverage:(Beverage *)beverage;

@end
