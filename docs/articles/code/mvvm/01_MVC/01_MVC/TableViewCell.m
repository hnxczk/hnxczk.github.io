//
//  TableViewCell.m
//  01_MVC
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()


@end

@implementation TableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (IBAction)addAction:(id)sender
{
    if (self.addClickBlock) {
        self.addClickBlock();
    }
}


@end
