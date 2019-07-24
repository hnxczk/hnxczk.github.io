//
//  NYPizzaIngredientFactory.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "NYPizzaIngredientFactory.h"

@implementation NYPizzaIngredientFactory

- (Dough *)createDough
{
    return [[ThinCrustDough alloc] init];
}

- (Sauce *)createSauce
{
    return [[MarinaraSauce alloc] init];
}

@end
