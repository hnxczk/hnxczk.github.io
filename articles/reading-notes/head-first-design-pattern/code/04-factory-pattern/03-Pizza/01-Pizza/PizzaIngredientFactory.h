//
//  PizzaIngredientFactory.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dough.h"
#import "Sauce.h"
#import "Cheese.h"
#import "Veggies.h"
#import "Pepperoni.h"

@protocol PizzaIngredientFactory <NSObject>

- (Dough *)createDough;
- (Sauce *)createSauce;

@end
