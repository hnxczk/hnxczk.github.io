//
//  Subject.h
//  01-Weather
//
//  Created by zhouke on 2018/6/19.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#ifndef Subject_h
#define Subject_h

@protocol Subject<NSObject>

@required
- (void)registerObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)notifyObservers;

@end

#endif /* Subject_h */
