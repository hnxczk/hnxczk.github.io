//
//  PizzaStore.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePizzaFactory.h"

@interface PizzaStore : NSObject

@property (nonatomic, strong) SimplePizzaFactory *factory;

- (Pizza *)orderPizzaByType:(NSString *)type;

@end
