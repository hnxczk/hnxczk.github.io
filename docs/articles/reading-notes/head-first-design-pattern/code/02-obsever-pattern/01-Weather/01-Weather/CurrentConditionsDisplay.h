//
//  CurrentConditionsDisplay.h
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Obsever.h"
#import "DisplayElement.h"
#import "Subject.h"

@interface CurrentConditionsDisplay : NSObject<Observer, DisplayElement>

- (instancetype)initWithWeatherData:(id<Subject>)weatherData;

@end
