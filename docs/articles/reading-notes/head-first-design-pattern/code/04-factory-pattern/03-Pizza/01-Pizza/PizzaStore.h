//
//  PizzaStore.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pizza.h"

@interface PizzaStore : NSObject

- (Pizza *)orderPizzaByType:(NSString *)type;

- (Pizza *)createPizzaByType:(NSString *)type;

@end
