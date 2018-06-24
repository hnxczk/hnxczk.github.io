//
//  CondimentDecorator.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//  

#import "CondimentDecorator.h"

@implementation CondimentDecorator

- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[Beverage class]], @"AbstractDownloader is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (NSString *)getDescript
{
    AbstractMethodNotImplemented();
    return [super getDescript];
}

@end
