//
//  main.swift
//  01-Duck
//
//  Created by zhouke on 2018/7/7.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation


var duck = MallardDuck()

var turkey = WildTurkey()
var turkeyAdapter = TurkeyAdapter(turkey: turkey)

duck.quack()
duck.fly()

turkey.gobble()
turkey.fly()

turkeyAdapter.quack()
turkeyAdapter.fly()


