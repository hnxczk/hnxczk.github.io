//
//  SimplePizzaFactory.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pizza.h"
#import "CheesePizza.h"
#import "GreekPizza.h"
#import "PepperoniPizza.h"

@interface SimplePizzaFactory : NSObject

- (Pizza *)createPizzaByType:(NSString *)type;

@end
