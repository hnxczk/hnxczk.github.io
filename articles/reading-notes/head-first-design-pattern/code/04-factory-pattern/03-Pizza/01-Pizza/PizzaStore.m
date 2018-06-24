//
//  PizzaStore.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "PizzaStore.h"

@implementation PizzaStore

- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[PizzaStore class]], @"AbstractDownloader is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (Pizza *)orderPizzaByType:(NSString *)type
{
    Pizza *pizza = [self createPizzaByType:type];
    
    [pizza prepare];
    [pizza bake];
    [pizza cut];
    [pizza box];
    
    return pizza;
}

// 实例化披萨的任务被放到一个方法中，并且由于它是抽象的
// 1. 因为该方法是抽象的因此需要依赖子类对象来处理
// 2. 工厂方法将 orderPizzaByType 与实际创建具体产品的子类对象的创建代码解耦了。
- (Pizza *)createPizzaByType:(NSString *)type
{
    AbstractMethodNotImplemented();
}

@end
