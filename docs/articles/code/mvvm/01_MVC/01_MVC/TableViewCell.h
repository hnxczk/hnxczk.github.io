//
//  TableViewCell.h
//  01_MVC
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (nonatomic,copy) void(^addClickBlock)(void);

@end
