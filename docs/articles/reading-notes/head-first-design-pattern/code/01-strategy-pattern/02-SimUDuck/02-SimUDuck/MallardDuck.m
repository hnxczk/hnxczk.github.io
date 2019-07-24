//
//  MallardDuck.m
//  02-SimUDuck
//
//  Created by zhouke on 2018/6/18.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "MallardDuck.h"
#import "Quack.h"
#import "FlyWithWings.h"

@implementation MallardDuck

- (instancetype)init
{
    if (self = [super init]) {
        self.quackBehavior = [[Quack alloc] init];
        self.flyBehavior = [[FlyWithWings alloc] init];
    }
    return self;
}

@end
