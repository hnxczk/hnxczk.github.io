//
//  VIewModel.m
//  02_MVVM
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import "VIewModel.h"
#import "Model.h"

@interface VIewModel ()

@end

@implementation VIewModel

// 模拟网络请求
- (void)requestModel
{
    Model *model = [[Model alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [array addObject:@(i)];
        model.totalCount += i;
    }
    model.countArray = array;
    
    self.model = model;
}

- (void)addActionAtIndex:(NSInteger)index
{
    NSNumber *count = self.model.countArray[index];
    NSInteger countInt = [count integerValue];
    NSMutableArray *countArray = [NSMutableArray arrayWithArray:self.model.countArray];
    countArray[index] = [NSNumber numberWithInteger:(countInt + 1)];
    self.model.countArray = countArray;
}


@end
