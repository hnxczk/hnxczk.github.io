//
//  Beverage.h
//  01-Beverage
//
//  Created by zhouke on 2018/6/23.
//  Copyright © 2018年 zhouke. All rights reserved.
//  这是一个抽象类，其中 getDescript 已经实现，而 cost 方法则要求子类必须实现

#import <Foundation/Foundation.h>

#define AbstractMethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

typedef NS_ENUM(NSUInteger, BeverageSize) {
    BeverageSizeTall,
    BeverageSizeGrande,
    BeverageSizeVenti,
};

@interface Beverage : NSObject

@property (nonatomic, copy) NSString *descript;
@property (nonatomic, assign) BeverageSize size;

- (NSString *)getDescript;
- (CGFloat)cost;

@end
