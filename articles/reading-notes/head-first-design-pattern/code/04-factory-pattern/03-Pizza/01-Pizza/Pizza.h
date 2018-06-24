//
//  Pizza.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PizzaIngredientFactory.h"

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@interface Pizza : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) Dough *dough;
@property (nonatomic, strong) Sauce *sauce;
@property (nonatomic, copy) NSMutableArray<NSString *> *toppings;

- (void)prepare;
- (void)bake;
- (void)cut;
- (void)box;

- (NSString *)getName;

@end
