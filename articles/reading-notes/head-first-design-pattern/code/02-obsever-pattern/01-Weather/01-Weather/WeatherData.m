//
//  WeatherData.m
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

- (instancetype)init
{
    if (self = [super init]) {
        self.observers = [NSMutableArray array];
    }
    return self;
}

- (void)registerObserver:(id)observer
{
    if (observer) {
        [self.observers addObject:observer];
    }
}

- (void)removeObserver:(id)observer
{
    if (observer) {
        [self.observers removeObject:observer];
    }
}

- (void)notifyObservers
{
    for (id<Observer> observer in self.observers) {
        [observer updateWithTemp:self.temperature humidity:self.humidity pressure:self.pressure];
    }
}

- (void)measurementsChanged
{
    [self notifyObservers];
}

- (void)setTemperature:(CGFloat)temperature humidity:(CGFloat)humidity pressure:(CGFloat)pressure
{
    self.temperature = temperature;
    self.humidity = humidity;
    self.pressure = pressure;
    [self measurementsChanged];
}

@end
