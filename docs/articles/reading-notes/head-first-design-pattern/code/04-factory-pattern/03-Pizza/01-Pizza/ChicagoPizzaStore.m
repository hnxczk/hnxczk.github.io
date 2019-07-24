//
//  ChicagoPizzaStore.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ChicagoPizzaStore.h"
#import "ClamPizza.h"
#import "CheesePizza.h"
#import "NYPizzaIngredientFactory.h"

@implementation ChicagoPizzaStore

- (Pizza *)createPizzaByType:(NSString *)type
{
    NYPizzaIngredientFactory *ingreditenFactory = [[NYPizzaIngredientFactory alloc] init];
    Pizza *pizza = nil;
    if ([type isEqualToString:@"cheese"]) {
        pizza = [[CheesePizza alloc] initWithIngredientFactory:ingreditenFactory];
    } else if ([type isEqualToString:@"clam"]) {
        pizza = [[ClamPizza alloc] initWithIngredientFactory:ingreditenFactory];
    }
    
    return pizza;
}
@end
