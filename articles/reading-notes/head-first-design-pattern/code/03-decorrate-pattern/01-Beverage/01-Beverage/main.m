//
//  main.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Espresso.h"
#import "DarkRose.h"
#import "HouseBlend.h"

#import "Mocha.h"
#import "Soy.h"
#import "Whip.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Beverage *beverage = [[Espresso alloc] init];
        NSLog(@"%@ $%.2f", [beverage getDescript], [beverage cost]);
        
        // 通过初始化方法初始化，变量 beverage2 的实际类型是 DarkRose（继承自 Beverage）
        Beverage *beverage2 = [[DarkRose alloc] init];
        
        // 装饰者 Mocha 的初始化方法初始化一个装饰器，beverage2 的实际类型是 Mocha（继承自 CondimentDecorator， 而它又继承自 Beverage），这时它内部的 _beverage 成员变量是上面异步初始化的 DarkRose
        beverage2 = [[Mocha alloc] initWithBeverage:beverage2];
        // 装饰者 Soy 的初始化方法初始化一个装饰器，beverage2 的实际类型是 Soy（继承自 CondimentDecorator， 而它又继承自 Beverage），这时它内部的 _beverage 成员变量是上面异步初始化的 Mocha
        beverage2 = [[Soy alloc] initWithBeverage:beverage2];
        // 装饰者 Whip 的初始化方法初始化一个装饰器，beverage2 的实际类型是 Whip（继承自 CondimentDecorator， 而它又继承自 Beverage），这时它内部的 _beverage 成员变量是上面异步初始化的 Soy
        beverage2 = [[Whip alloc] initWithBeverage:beverage2];
        
        // 现在 beverage2 的类型是 Whip， 因此该方法会先去调 Whip 的 getDescript， 而后是 Soy 的 getDescript，接着是 Mocha 的 getDescript 最后是 DarkRose 继承自父类的方法 getDescript 返回自己的成员变量 _descript， 它的值是 @"Dark Rose Coffee"
        NSString *descript = [beverage2 getDescript];
        // cost 方法的调用过程同上
        CGFloat cost = [beverage2 cost];
        NSLog(@"%@ $%.2f", descript, cost);

        Beverage *beverage3 = [[HouseBlend alloc] init];
        beverage3 = [[Mocha alloc] initWithBeverage:beverage3];
        beverage3 = [[Whip alloc] initWithBeverage:beverage3];
        NSLog(@"%@ $%.2f", [beverage3 getDescript], [beverage3 cost]);

    }
    return 0;
}


