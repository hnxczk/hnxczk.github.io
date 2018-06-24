//
//  SimplePizzaFactory.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "SimplePizzaFactory.h"

@implementation SimplePizzaFactory

- (Pizza *)createPizzaByType:(NSString *)type
{
    Pizza *pizza = nil;
    if ([type isEqualToString:@"cheese"]) {
        pizza = [[CheesePizza alloc] init];
    } else if ([type isEqualToString:@"greek"]) {
        pizza = [[GreekPizza alloc] init];
    } else if ([type isEqualToString:@"pepperoni"]) {
        pizza = [[PepperoniPizza alloc] init];
    }
    
    return pizza;
}

@end
