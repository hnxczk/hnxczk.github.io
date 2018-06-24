//
//  PizzaStore.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "PizzaStore.h"

@implementation PizzaStore

- (instancetype)initWithFactory:(SimplePizzaFactory *)factory
{
    if (self = [super init]) {
        _factory = factory;
    }
    return self;
}

- (Pizza *)orderPizzaByType:(NSString *)type
{
    Pizza *pizza = [self.factory createPizzaByType:type];
    
    [pizza prepare];
    [pizza bake];
    [pizza cut];
    [pizza box];
    
    return pizza;
}

@end
