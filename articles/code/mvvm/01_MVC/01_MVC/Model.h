//
//  Model.h
//  01_MVC
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, strong) NSArray <NSNumber *>*countArray;

@end
