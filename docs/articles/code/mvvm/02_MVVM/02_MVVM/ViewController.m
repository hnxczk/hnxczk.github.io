//
//  ViewController.m
//  02_MVVM
//
//  Created by zhouke on 2018/9/30.
//  Copyright © 2018 zhouke. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "VIewModel.h"
#import "Model.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) VIewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.viewModel requestModel];
    
    [self.viewModel.model addObserver:self forKeyPath:@"countArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"countArray"]) {
        self.title = [NSString stringWithFormat:@"%ld", (long)self.viewModel.model.totalCount];
        [self.tableView reloadData];
    }
}

- (void)dealloc
{
    [self.viewModel.model removeObserver:self forKeyPath:@"countArray"];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.model.countArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    NSNumber *count = self.viewModel.model.countArray[indexPath.row];
    [cell.countBtn setTitle:[NSString stringWithFormat:@"%@", count] forState:UIControlStateNormal];
    __weak __typeof(self)weakSelf = self;
    cell.addClickBlock = ^{
        [weakSelf.viewModel addActionAtIndex:indexPath.row];
    };
    return cell;
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

- (VIewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[VIewModel alloc] init];
    }
    return _viewModel;
}

@end
