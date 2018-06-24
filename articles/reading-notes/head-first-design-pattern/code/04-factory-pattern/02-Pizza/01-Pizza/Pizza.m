//
//  Pizza.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Pizza.h"

@implementation Pizza

- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[Pizza class]], @"AbstractDownloader is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (void)prepare
{
    NSLog(@"Preparing %@", self.name);
    NSLog(@"Tossing Dough");
    NSLog(@"Adding sauce");
    NSLog(@"Adding toppings");
    for (NSString *topping in self.toppings) {
        NSLog(@"%@", topping);
    }
}

- (void)bake
{
    NSLog(@"Bake for 25 minutes at 350");
}
- (void)cut
{
    NSLog(@"Cutting the pizza into diagonal slices");
}

- (void)box
{
    NSLog(@"Place pizza in official PizzaStore box");
}

- (NSString *)getName
{
    return self.name;
}

- (NSMutableArray<NSString *> *)toppings
{
    if (!_toppings) {
        _toppings = [NSMutableArray array];
    }
    return _toppings;
}

@end
