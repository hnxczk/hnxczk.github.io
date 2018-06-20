//
//  Obsever.h
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#ifndef Obsever_h
#define Obsever_h

@protocol Observer<NSObject>

@required
- (void)updateWithTemp:(CGFloat)temp humidity:(CGFloat)humidity pressure:(CGFloat)pressure;

@end

#endif /* Obsever_h */
