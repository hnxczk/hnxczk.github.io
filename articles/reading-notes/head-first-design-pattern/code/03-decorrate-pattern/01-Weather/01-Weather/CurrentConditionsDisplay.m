//
//  CurrentConditionsDisplay.m
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "CurrentConditionsDisplay.h"
#import "Subject.h"

@interface CurrentConditionsDisplay()

@property (nonatomic, assign) CGFloat temperature;
@property (nonatomic, assign) CGFloat humidity;

@property (nonatomic, strong) id<Subject> weatherata;
@end

@implementation CurrentConditionsDisplay

- (instancetype)initWithWeatherData:(id<Subject>)weatherData
{
    if (self = [super init]) {
        self.weatherata = weatherData;
        [self.weatherata registerObserver:self];
    }
    return self;
}

- (void)updateWithTemp:(CGFloat)temp humidity:(CGFloat)humidity pressure:(CGFloat)pressure
{
    self.temperature = temp;
    self.humidity = humidity;
    [self display];
}

- (void)display
{
    NSLog(@"Current condation : %.1f F degress and %.1f humidity", self.temperature, self.humidity);
}

@end
