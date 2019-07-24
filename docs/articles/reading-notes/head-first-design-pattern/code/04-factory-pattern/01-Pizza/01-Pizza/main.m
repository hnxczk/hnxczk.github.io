//
//  main.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PizzaStore.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        PizzaStore *store = [[PizzaStore alloc] init];
        Pizza *pizza = [store orderPizzaByType:@"cheese"];

    }
    return 0;
}


//Pizza* orderPizzaByType(NSString *type)
//{
//    Pizza *pizza = nil;
//    if ([type isEqualToString:@"chesse"]) {
//        pizza = [[ChessePizza alloc] init];
//    } else if ([type isEqualToString:@"greek"]) {
//        pizza = [[GreekPizza alloc] init];
//    } else if ([type isEqualToString:@"pepperoni"]) {
//        pizza = [[PepperoniPizza alloc] init];
//    }
//    
//    [pizza prepare];
//    [pizza bake];
//    [pizza cut];
//    [pizza box];
//
//    return pizza;
//}
