//
//  main.swift
//  01-Singleton
//
//  Created by zhouke on 2018/6/25.
//  Copyright © 2018年 zhouke. All rights reserved.
//

import Foundation


//var signleton = Singleton.share();
//var signleton2 = Singleton.share();


var chocolateBoiler = ChocolateBoiler.share()

DispatchQueue.global().async {
    chocolateBoiler.fill()
    chocolateBoiler.boil()
    chocolateBoiler.drain()
}

DispatchQueue.global().async {
    chocolateBoiler.fill()
    chocolateBoiler.boil()
    chocolateBoiler.drain()
}
