//
//  ViewController.m
//  03-KVO
//
//  Created by zhouke on 2018/6/21.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.count = 10;
}

@end
