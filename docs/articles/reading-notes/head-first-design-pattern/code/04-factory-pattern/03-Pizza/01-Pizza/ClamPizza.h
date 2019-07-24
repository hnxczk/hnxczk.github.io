//
//  ClamPizza.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Pizza.h"
#import "PizzaIngredientFactory.h"

@interface ClamPizza : Pizza

@property (nonatomic, strong) id<PizzaIngredientFactory> ingredientFactory;

- (instancetype)initWithIngredientFactory:(id<PizzaIngredientFactory>) ingredientFactory;

@end
