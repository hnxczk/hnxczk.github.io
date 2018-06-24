//
//  NYPizzaStore.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "NYPizzaStore.h"
#import "NYCheesePizza.h"
#import "NYVeggisPizza.h"

@implementation NYPizzaStore

- (Pizza *)createPizzaByType:(NSString *)type
{
    Pizza *pizza = nil;
    if ([type isEqualToString:@"cheese"]) {
        pizza = [[NYCheesePizza alloc] init];
    } else if ([type isEqualToString:@"veggie"]) {
        pizza = [[NYVeggisPizza alloc] init];
    }
    
    return pizza;
}

@end
