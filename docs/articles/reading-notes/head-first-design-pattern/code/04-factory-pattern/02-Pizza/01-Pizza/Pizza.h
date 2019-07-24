//
//  Pizza.h
//  01-Pizza
//
//  Created by zhouke on 2018/6/24.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pizza : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *dough;
@property (nonatomic, copy) NSString *sauce;
@property (nonatomic, copy) NSMutableArray<NSString *> *toppings;

- (void)prepare;
- (void)bake;
- (void)cut;
- (void)box;

- (NSString *)getName;

@end
