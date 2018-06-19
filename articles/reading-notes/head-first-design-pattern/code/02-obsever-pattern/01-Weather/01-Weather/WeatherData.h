//
//  WeatherData.h
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subject.h"
#import "Obsever.h"

@interface WeatherData : NSObject<Subject>

@property (nonatomic, assign) CGFloat temperature;
@property (nonatomic, assign) CGFloat humidity;
@property (nonatomic, assign) CGFloat pressure;

@property (nonatomic, strong) NSMutableArray<id<Observer>> *observers;

// 一旦气象测量更新，此方法会被调用
- (void)measurementsChanged;
- (void)setTemperature:(CGFloat)temperature humidity:(CGFloat)humidity pressure:(CGFloat)pressure;

@end
