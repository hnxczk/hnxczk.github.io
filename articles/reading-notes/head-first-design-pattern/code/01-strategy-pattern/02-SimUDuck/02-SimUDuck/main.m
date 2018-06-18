//
//  main.m
//  02-SimUDuck
//
//  Created by zhouke on 2018/6/18.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MallardDuck.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MallardDuck *mallardDuck = [[MallardDuck alloc] init];
        [mallardDuck performFly];
        [mallardDuck performQuack];
        
    }
    return 0;
}
