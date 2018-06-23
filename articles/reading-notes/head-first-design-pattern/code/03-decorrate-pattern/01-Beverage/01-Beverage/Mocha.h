//
//  Mocha.h
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//  一个装饰者继承自 CondimentDecorator

#import "CondimentDecorator.h"

@interface Mocha : CondimentDecorator

// 记录被装饰者的属性
@property (nonatomic, strong) Beverage *beverage;

// 把被修饰者作为参数构造装饰者
- (instancetype)initWithBeverage:(Beverage *)beverage;

@end
