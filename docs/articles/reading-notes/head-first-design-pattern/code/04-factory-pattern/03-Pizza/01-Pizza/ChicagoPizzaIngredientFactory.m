//
//  ChicagoPizzaIngredientFactory.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ChicagoPizzaIngredientFactory.h"

@implementation ChicagoPizzaIngredientFactory

- (Dough *)createDough
{
    return [[ThickCrustDough alloc] init];
}

- (Sauce *)createSauce
{
    return [[PlumTomatoSauce alloc] init];
}

@end
