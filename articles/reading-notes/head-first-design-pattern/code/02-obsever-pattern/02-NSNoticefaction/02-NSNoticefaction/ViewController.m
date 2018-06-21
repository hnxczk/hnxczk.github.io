//
//  ViewController.m
//  02-NSNoticefaction
//
//  Created by zhouke on 2018/6/21.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ViewController.h"

#define NOTIFICATION_NAME @"NSNotificationName"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeAction) name:NOTIFICATION_NAME object:nil];
}

- (void)noticeAction
{
    NSLog(@"getNotice");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME object:nil userInfo:nil];
}


@end
