//
//  Duck.m
//  01-SimUDuck
//
//  Created by zhouke on 2018/6/18.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Duck.h"

@implementation Duck

- (void)performQuack
{
    [self.quackBehavior qucak];
}

- (void)performFly
{
    [self.flyBehavior fly];
}

- (void)swim
{
    NSLog(@"swim");
}

- (void)display
{
    NSLog(@"display");
}


@end
