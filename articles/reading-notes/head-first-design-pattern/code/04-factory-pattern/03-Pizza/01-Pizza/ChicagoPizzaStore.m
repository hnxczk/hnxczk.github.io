//
//  ChicagoPizzaStore.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ChicagoPizzaStore.h"
#import "ChicagoCheesePizza.h"
#import "ChicagoVeggicePizza.h"

@implementation ChicagoPizzaStore

- (Pizza *)createPizzaByType:(NSString *)type
{
    Pizza *pizza = nil;
    if ([type isEqualToString:@"cheese"]) {
        pizza = [[ChicagoCheesePizza alloc] init];
    } else if ([type isEqualToString:@"veggice"]) {
        pizza = [[ChicagoVeggicePizza alloc] init];
    }
    
    return pizza;
}
@end
