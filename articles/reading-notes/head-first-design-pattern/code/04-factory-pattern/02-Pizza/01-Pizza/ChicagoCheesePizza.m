//
//  ChicagoCheesePizza.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ChicagoCheesePizza.h"

@implementation ChicagoCheesePizza

- (instancetype)init
{
    if (self = [super init]) {
        self.name = @"Chicago Style Deep Dish Cheese Pizza";
        self.dough = @"Extra Thick Crust Dough";
        self.sauce = @"Plum Tomato Sauce";
        [self.toppings addObject:@"Shredded Reggiano Cheese"];
    }
    return self;
}

- (void)cut
{
    NSLog(@"Cutting the pizza into square slices");
}


@end
