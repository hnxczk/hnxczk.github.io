//
//  main.m
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYPizzaStore.h"
#import "ChicagoPizzaStore.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        PizzaStore *nyStore = [[NYPizzaStore alloc] init];
        Pizza *nyPizza = [nyStore orderPizzaByType:@"cheese"];
        NSLog(@"Ethan ordered a %@", nyPizza.getName);
        
        NSLog(@"---------");
        
        PizzaStore *chicagoStore = [[ChicagoPizzaStore alloc] init];
        Pizza *chicagoPizza = [chicagoStore orderPizzaByType:@"cheese"];
        NSLog(@"Joel ordered a %@", chicagoPizza.getName);

    }
    return 0;
}

