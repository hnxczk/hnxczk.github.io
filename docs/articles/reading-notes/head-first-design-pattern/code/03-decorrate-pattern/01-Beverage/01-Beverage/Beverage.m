//
//  Beverage.m
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "Beverage.h"

@implementation Beverage

#warning 由于 OC 中没有提供声明抽象类的方法，因此通过断言来实现
- (instancetype)init
{
    NSAssert(![self isMemberOfClass:[Beverage class]], @"AbstractDownloader is an abstract class, you should not instantiate it directly.");
    return [super init];
}

- (NSString *)getDescript
{
    return _descript;
}

- (CGFloat)cost
{
    AbstractMethodNotImplemented();
}

@end
