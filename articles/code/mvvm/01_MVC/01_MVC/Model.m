//
//  Model.m
//  01_MVC
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import "Model.h"

@implementation Model

- (NSInteger)totalCount
{
    NSInteger count = 0;
    for (NSNumber *ct in self.countArray) {
        count += [ct integerValue];
    }
    return count;
}


@end
