//
//  main.m
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentConditionsDisplay.h"
#import "WeatherData.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        WeatherData *weather = [[WeatherData alloc] init];
        
        CurrentConditionsDisplay *display = [[CurrentConditionsDisplay alloc] initWithWeatherData:weather];
        
        [weather setTemperature:80 humidity:65 pressure:30];
    }
    return 0;
}
