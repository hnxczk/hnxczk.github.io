//
//  NYCheesePizza.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "NYCheesePizza.h"

@implementation NYCheesePizza

- (instancetype)init
{
    if (self = [super init]) {
        self.name = @"NY Style Sauce and Cheese Pizza";
        self.dough = @"Thin Crust Dough";
        self.sauce = @"Marinara Sauce";
        [self.toppings addObject:@"Grated Reggiano Cheese"];
    }
    return self;
}

@end
