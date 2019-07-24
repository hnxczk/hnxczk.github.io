//
//  Duck.h
//  01-SimUDuck
//
//  Created by zhouke on 2018/6/18.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlyBehavior.h"
#import "QuackBehavior.h"

@interface Duck : NSObject

@property (nonatomic, strong) id<QuackBehavior> quackBehavior;
@property (nonatomic, strong) id<FlyBehavior> flyBehavior;

- (void)performQuack;
- (void)performFly;
- (void)swim;
- (void)display;

@end
