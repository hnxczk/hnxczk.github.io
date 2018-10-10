//
//  ViewController.m
//  01_MVC
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "Model.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Model *model;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self requestModel];
    [self.model addObserver:self forKeyPath:@"countArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
}

- (void)dealloc
{
    [self.model removeObserver:self forKeyPath:@"countArray"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"countArray"]) {
        self.title = [NSString stringWithFormat:@"%ld", (long)self.model.totalCount];
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.countArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    NSNumber *count = self.model.countArray[indexPath.row];
    [cell.countBtn setTitle:[NSString stringWithFormat:@"%@", count] forState:UIControlStateNormal];
    __weak __typeof(self)weakSelf = self;
    cell.addClickBlock = ^{
        [weakSelf addActionAtIndex:indexPath.row];
    };
    return cell;
}

- (void)addActionAtIndex:(NSInteger)index
{
    NSNumber *count = self.model.countArray[index];
    NSInteger countInt = [count integerValue];
    NSMutableArray *countArray = [NSMutableArray arrayWithArray:self.model.countArray];
    countArray[index] = [NSNumber numberWithInteger:(countInt + 1)];
    self.model.countArray = countArray;
}

// 模拟网络请求
- (void)requestModel
{
    Model *model = [[Model alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [array addObject:@(i)];
        model.totalCount += i;
    }
    model.countArray = array;
    
    self.model = model;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    }
    return _tableView;
}


@end
