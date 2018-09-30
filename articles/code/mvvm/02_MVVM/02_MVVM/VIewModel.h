//
//  VIewModel.h
//  02_MVVM
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Model;

@interface VIewModel : NSObject

@property (nonatomic, strong) Model *model;

// 模拟网络请求
- (void)requestModel;
- (void)addActionAtIndex:(NSInteger)index;

@end
