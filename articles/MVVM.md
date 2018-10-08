# MVVM 实战

首先我们知道 MVC 已经拥有将近 50 年的历史，是最出名并且应用最广泛的架构模式。至于后来的 MVVM, MVP 等架构模式都是在它基础之上发展出来的。因此我们先来大致了解（或者复习）下 MVC。

## MVC
在 iOS 开发中，MVC 是苹果推荐的一个用来组织代码的权威范式,是构建iOS App的标准模式。按照 MVC 可以将整个应用分成 Model、View 和 Controller 三个部分。

- 视图（View）：负责渲染和展示内容，比如处理显示的字体间距位置等；
- 模型（Model）：单纯的数据结构数据，一般用来承载服务器返回的数据；
- 控制器（Controller）：负责控制视图和模型，比如管理视图的生命周期，发起网络请求获取模型数据，根据模型控制视图显示，处理用户交互等等。

下图是他们之间的依赖关系。

![](./images/mvvm1.png)

具体可以参考我写的一个 [demo](./code/mvvm/01_MVC)

这个例子中主要模拟了一个常见的业务场景。从服务器获取数据并展示，然后当用户点击的时候处理点击事件，并修改数据然后展示修改后的界面。

下面这是 Controller 里的部分代码。
```
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
```

在 demo 中 Controller 持有 View 和 Model。View 的交互事件通过 Block 传递到 Controller，然后控制器处理完业务逻辑后修改 Model。同时 Controller 通过 KVO 监听 Model 的改变后刷新界面。

通过这个结构可以看出来 View 和 Model 层的责任较为单一，比较轻量。相应的 Controller 层的责任就比较复杂了。

例子中 Controller 的职责（包括但不仅限于）：

- 管理根视图的生命周期和应用生命周期
- 负责将视图层的 UIView 对象添加到持有的根视图上；
- 负责处理用户行为，比如 UIButton 的点击；
- 作为 UITableView 以及其它容器视图的代理以及数据源；
- 负责 HTTP 请求的发起；
- 处理业务逻辑

在加上 Cocoa Touch 框架中 UIViewController 类持有一个根视图 UIView，所以视图层与控制器层是紧密耦合在一起的，这也是 iOS 项目经常遇到视图控制器非常臃肿的重要原因之一。因此 iOS 的依赖关系往往会被视为下面这种

![](./images/mvvm2.png)

## MVVM

相对于 MVC ， MVVM 最大的不同就是多抽象出来了一个 ViewModel 层。他们之间的依赖关系就变成了下图这样。

![](./images/mvvm3.png)

那什么东西是应该放入 ViewModel 呢？

根据个人的经验来说网络请求，业务逻辑，处理转换模型等代码都可以放入其中。

这是 [demo](./code/mvvm/02_MVVM)

Controller
```
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
```

ViewModel
```
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

- (void)addActionAtIndex:(NSInteger)index
{
    NSNumber *count = self.model.countArray[index];
    NSInteger countInt = [count integerValue];
    NSMutableArray *countArray = [NSMutableArray arrayWithArray:self.model.countArray];
    countArray[index] = [NSNumber numberWithInteger:(countInt + 1)];
    self.model.countArray = countArray;
}
```

这样以来业务代码基本上都在 ViewModel 中了。而在实际开发中业务的变化往往是变化最多的。这样以来后续的修改都被隔离在了 ViewModel 中。修改起来就比较方便了。

通过上面我们可以看出来 MVVM 可以看成是一个 MVC 的增强版，因此它可以完全兼容 MVC ，可以很好的介入到项目中。

另外需要注意的是 MVVM 配合一个绑定机制效果最好（比如大名鼎鼎的 ReactiveCocoa）。但是并不是说只能用 ReactiveCocoa 或者 RXSwift 来进行绑定。 我们可以结合使用 KVO 来做数据的同步。就像我在 demo 中的用法。当然了系统提供的 KVO 使用起来泰国麻烦和危险，一般在项目中使用的都是 Facebook 开源的 FBKVOController 。当然也会有一些坑需要注意，可以参考我的[这篇](./NSHashTable-NSMapTable.md)文章.



