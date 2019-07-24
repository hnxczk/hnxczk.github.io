//
//  ClamPizza.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ClamPizza.h"

@implementation ClamPizza

- (instancetype)initWithIngredientFactory:(id<PizzaIngredientFactory>) ingredientFactory
{
    if (self = [super init]) {
        self.ingredientFactory = ingredientFactory;
    }
    return self;
}

- (void)prepare
{
    NSLog(@"Preparing %@", self.name);
    self.dough = [self.ingredientFactory createDough];
    self.sauce = [self.ingredientFactory createSauce];
}

@end
