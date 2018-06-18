# iOS 代码规范

## 一. 通用规范
### 大括号
- 控制语句(if,for,while,switch)中，大括号开始与行尾(行尾大括号前要加上一个空格)
- 函数中，大括号要开始于行首
推荐这样写：

```
//控制语句
white (someCondition) {
}
//函数
void function(param1,param2)
{

}
```
### 运算符
#### 1.运算符与变量之间的间隔
##### 1.1一元运算符与变量之间没有空格：

```
!bValue
~iValue
++iCount
*strSource
&fSum
```
##### 1.2 二元运算符与变量之间必须有空格

```
fWidth = 5 + 5;
fLength = fWidth * 2;
fHeight = fWidth + fLength;
for(int i = 0; i < 10; i++)
```
#### 2.多个不同的运算符同时存在时应该使用括号来明确优先级
在多个不同的运算符同时存在的时候应该合理使用括号，不要盲目依赖操作符优先级。
因为有的时候不能保证阅读你代码的人就一定能了解你写的算式里面所有操作符的优先级。

来看一下这个算式：`2 << 2 + 1 * 3 - 4`

这里的 << 是移位操作直观上却很容易认为它的优先级很高，所以就把这个算式误认为：`(2 << 2) + 1 3 - 4`。
但事实上，它的优先级是比加减法还要低的，所以该算式应该等同于：`2 << (2 + 1 3 - 4)`。
所以在以后写这种复杂一点的算式的时候，尽量多加一点括号，避免让其他人误解（甚至是自己）。

### 变量
1. 一个变量有且只有一个功能，尽量不要把一个变量用作多种用途
2. 变量在使用前应初始化，防止未初始化的变量被引用
3. 局部变量应该尽量接近使用它的地方

推荐这样写：

```
func someFunction() {
 
  let index = ...;
  //Do something With index
  ...
  ...
  
  let count = ...;
  //Do something With count
  
}
```

不推荐这样写：

```
func someFunction() {
 
  let index = ...;
  let count = ...;
  //Do something With index
  ...
  ...
  
  //Do something With count
}
```

### if语句
#### 1. 必须列出所有分支（穷举所有的情况），而且每个分支都必须给出明确的结果。
推荐这样写：

```
var hintStr;
if (count < 3) {
  hintStr = "Good";
} else {
  hintStr = "";
}
```
不推荐这样写：

```
var hintStr;
if (count < 3) {
 hintStr = "Good";
}
```
#### 2. 不要使用过多的分支，要善于使用return来提前返回错误的情况
推荐这样写：

```
- (void)someMethod { 
  if (!goodCondition) {
    return;
  }
  //Do something
}
```
不推荐这样写：

```
- (void)someMethod { 
  if (goodCondition) {
    //Do something
  }
}
```
比较典型的例子在JSONModel里遇到过：

```
-(id)initWithDictionary:(NSDictionary*)dict error:(NSError)err
{
   //方法1. 参数为nil
   if (!dict) {
     if (err) *err = [JSONModelError errorInputIsNil];
     return nil;
    }
    //方法2. 参数不是nil，但也不是字典
    if (![dict isKindOfClass:[NSDictionary class]]) {
        if (err) *err = [JSONModelError errorInvalidDataWithMessage:@"Attempt to initialize JSONModel object using initWithDictionary:error: but the dictionary parameter was not an 'NSDictionary'."];
        return nil;
    }
    //方法3. 初始化
    self = [self init];
    if (!self) {
        //初始化失败
        if (err) *err = [JSONModelError errorModelIsInvalid];
        return nil;
    }
    //方法4. 检查用户定义的模型里的属性集合是否大于传入的字典里的key集合（如果大于，则返回NO）
    if (![self __doesDictionary:dict matchModelWithKeyMapper:self.__keyMapper error:err]) {
        return nil;
    }
    //方法5. 核心方法：字典的key与模型的属性的映射
    if (![self __importDictionary:dict withKeyMapper:self.__keyMapper validation:YES error:err]) {
        return nil;
    }
    //方法6. 可以重写[self validate:err]方法并返回NO，让用户自定义错误并阻拦model的返回
    if (![self validate:err]) {
        return nil;
    }
    //方法7. 终于通过了！成功返回model
    return self;
}
```
可以看到，在这里，首先判断出各种错误的情况然后提前返回，把最正确的情况放到最后返回。

#### 3. 条件表达式如果很长，则需要将他们提取出来赋给一个BOOL值
推荐这样写：

```
let nameContainsSwift = sessionName.hasPrefix("Swift")
let isCurrentYear = sessionDateCompontents.year == 2014
let isSwiftSession = nameContainsSwift && isCurrentYear
if (isSwiftSession) { 
   // Do something
}
```
不推荐这样写：

```
if ( sessionName.hasPrefix("Swift") && (sessionDateCompontents.year == 2014) ) { 
    // Do something
}
```
#### 4. 每个分支的实现代码都必须被大括号包围
推荐这样写：

```
if (!error) {
  return success;
}
```
不推荐这样写：

```
if (!error)
    return success;
```
或者

```
if (!error) return success;
```
#### 5. 条件过多，过长的时候应该换行
推荐这样写：

```
if (condition1() && 
    condition2() && 
    condition3() && 
    condition4()) {
  // Do something
}
```
不推荐这样写：

```
if (condition1() && condition2() && condition3() && condition4()) {
  // Do something
}
```
### for语句

#### 1. 不可在for循环内修改循环变量，防止for循环失去控制。

```
for (int index = 0; index < 10; index++) {
   ...
   logicToChange(index)
}
```

### Switch语句
#### 1. 每个分支都必须用大括号括起来
推荐这样写：

```
switch (integer) {  
  case 1:  {
    // ...  
   }
    break;  
  case 2: {  
    // ...  
    break;  
  }  
  case 3: {
    // ...  
    break; 
  }
  default:{
    // ...  
    break; 
  }
}
```
#### 2. 使用枚举类型时，不能有default分支， 除了使用枚举类型以外，都必须有default分支

```
RWTLeftMenuTopItemType menuType = RWTLeftMenuTopItemMain;  
switch (menuType) {  
  case RWTLeftMenuTopItemMain: {
    // ...  
    break; 
   }
  case RWTLeftMenuTopItemShows: {
    // ...  
    break; 
  }
  case RWTLeftMenuTopItemSchedule: {
    // ...  
    break; 
  }
}
```
在Switch语句使用枚举类型的时候，如果使用了default分支，在将来就无法通过编译器来检查新增的枚举类型了。

### 函数
#### 1. 一个函数的长度尽量限制在50行以内
通常来说，在阅读一个函数的时候，如果视需要跨过很长的垂直距离会非常影响代码的阅读体验。如果需要来回滚动眼球或代码才能看全一个方法，就会很影响思维的连贯性，对阅读代码的速度造成比较大的影响。最好的情况是在不滚动眼球或代码的情况下一眼就能将该方法的全部代码映入眼帘。

#### 2. 一个函数只做一件事（单一原则）
每个函数的职责都应该划分的很明确（就像类一样）。

推荐这样写：

```
dataConfiguration()
viewConfiguration()
```
不推荐这样写：

```
void dataConfiguration()
{   
   ...
   viewConfiguration()
}
```
#### 3. 对于有返回值的函数（方法），每一个分支都必须有返回值
推荐这样写：

```
int function()
{
    if(condition1) {
        return count1
    }else if(condition2) {
        return count2
    }else{
       return defaultCount
    } 
}
```
不推荐这样写：

```
int function()
{
    if(condition1) {
        return count1
    }else if(condition2) {
        return count2
    }
}
```
#### 4. 对输入参数的正确性和有效性进行检查，参数错误立即返回
推荐这样写：

```
void function(param1,param2)
{
      if(param1 is unavailable) {
           return;
      }
    
      if(param2 is unavailable) {
           return;
      }
     //Do some right thing
}
```
#### 5. 如果在不同的函数内部有相同的功能，应该把相同的功能抽取出来单独作为另一个函数
原来的调用：

```
void logic() {
  a();
  b()；
  if (logic1 condition) {
    c();
  } else {
    d();
  }
}
```
将a，b函数抽取出来作为单独的函数

```
void basicConfig() {
  a();
  b();
}
  
void logic1() {
  basicConfig();
  c();
}
void logic2() {
  basicConfig();
  d();
}
```
#### 6. 将函数内部比较复杂的逻辑提取出来作为单独的函数
一个函数内的不清晰（逻辑判断比较多，行数较多）的那片代码，往往可以被提取出去，构成一个新的函数，然后在原来的地方调用它这样你就可以使用有意义的函数名来代替注释，增加程序的可读性。

举一个发送邮件的例子：

```
openEmailSite();
login();
writeTitle(title);
writeContent(content);
writeReceiver(receiver);
addAttachment(attachment);
send();
```
中间的部分稍微长一些，我们可以将它们提取出来：

```
void writeEmail(title, content,receiver,attachment)
{
  writeTitle(title);
  writeContent(content);
  writeReceiver(receiver);
  addAttachment(attachment); 
}
```
然后再看一下原来的代码：

```
openEmailSite();
login();
writeEmail(title, content,receiver,attachment)
send();
```
#### 7. 避免使用全局变量，类成员（class member）来传递信息，尽量使用局部变量和参数。
在一个类里面，经常会有传递某些变量的情况。而如果需要传递的变量是某个全局变量或者属性的时候，有些朋友不喜欢将它们作为参数，而是在方法内部就直接访问了：

```
 class A {
   var x;
   func updateX() {
      ...
      x = ...;
   }
   func printX() {
     updateX();
     print(x);
   }
 }
```
 
我们可以看到，在printX方法里面，updateX和print方法之间并没有值的传递，乍一看我们可能不知道x从哪里来的，导致程序的可读性降低了。

而如果你使用局部变量而不是类成员来传递信息，那么这两个函数就不需要依赖于某一个类，而且更加容易理解，不易出错：

```
func updateX() -> String {
    x = ...;
    return x;
 }
 func printX() {
   String x = updateX();
   print(x);
 }
```

#### 8.如果一个函数有特别多的参数或者名称很长，应该将其按照 : 来对齐分行显示：

```
- (id)initWithModel:(IPCModle)model
        ConnectType:(IPCConnectType)connectType
         Resolution:(IPCResolution)resolution
           AuthName:(NSString *)authName
           Password:(NSString *)password；
```
### 注释
优秀的代码大部分是可以自描述的，我们完全可以用程代码本身来表达它到底在干什么，而不需要注释的辅助。

但并不是说一定不能写注释，有以下三种情况比较适合写注释：

- 公共接口（注释要告诉阅读代码的人，当前类能实现什么功能）。
- 涉及到比较深层专业知识的代码（注释要体现出实现原理和思想）。
- 容易产生歧义的代码（但是严格来说，容易让人产生歧义的代码是不允许存在的）。

除了上述这三种情况，如果别人只能依靠注释才能读懂你的代码的时候，就要反思代码出现了什么问题。

最后，对于注释的内容，相对于“做了什么”，更应该说明“为什么这么做”。

#### 注释的格式

##### 单行注释
注释单独一行，并与被注释的代码齐平，文字与 `//` 之间留一个空格

```
// 友盟统计事件
HomeHandleDataModel *handleModel = [HomeHandleDataModel sharedHandleDataModel];
[handleModel umengEvent:self.title];
```
注释跟在被注释代码后面时先加个空格后写 `//` 再留个空格后写注释文字

```
UIButton *addBtn // 添加按钮
UILabel *nameLbl // 名字标签
```

##### 复杂文件
在复杂文件比如较大的 controller 中使用 `#pragma mark - xxx `标签进行分隔代码功能区域，分隔清晰会保证后续需要查找摸个方法时能勾清晰查找到你需要定位的方法。

##### 暴露给外部调用的接口
提供给别人使用的公共控件或工具类需要提供文档注释，标清方法作用及各个参数的含义。

```
/**
 网络请求的实例方法（无缓存）

 @param type get/post
 @param urlString 请求的地址
 @param paraments 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 */
+(void)requestWithType:(HttpRequestType)type
         withUrlString:(NSString *)urlString
         withParaments:(id)paraments
      withSuccessBlock:(HttpRequstSuccess)successBlock
      withFailureBlock:(HttpRequestFailureCode)failureBlock
              progress:(HttpDownloadProgress)progress;
```


## 二. OC规范
### 变量
#### 1. 变量名必须使用驼峰格式
类，协议使用大驼峰：（首字母大写）

```
HomePageViewController.h
<HeaderViewDelegate>
```

对象等局部变量使用小驼峰：（首字母小写）

```
NSString *personName = @"";
NSUInteger totalCount = 0;
```
#### 2. 变量的名称必须同时包含功能与类型

```
UIButton *addBtn // 添加按钮
UILabel *nameLbl // 名字标签
NSString *addressStr // 地址字符串
```
#### 3. 系统常用类作实例变量声明时加入后缀
```
类型	后缀
UIViewController	VC
UIView	View
UILabel	Lbl
UIButton	Btn
UIImage	Img
UIImageView	ImagView
NSArray	Array
NSMutableArray	Marray
NSDictionary	Dict
NSMutableDictionary	Mdict
NSString	Str
NSMutableString	MStr
NSSet	Set
NSMutableSet	Mset
```
### 常量
#### 1. 常量以相关类名作为前缀
推荐这样写：

```
static const NSTimeInterval ZOCSignInViewControllerFadeOutAnimationDuration = 0.4;
```
不推荐这样写：

```
static const NSTimeInterval fadeOutTime = 0.4;
```
#### 2. 建议使用类型常量，不建议使用#define预处理命令
首先比较一下这两种声明常量的区别：

- 预处理命令：简单的文本替换，不包括类型信息，并且可被任意修改。
- 类型常量：包括类型信息，并且可以设置其使用范围，而且不可被修改。

使用预处理虽然能达到替换文本的目的，但是本身还是有局限性的：

- 不具备类型信息。
- 可以被任意修改。

#### 3. 对外公开某个常量：
如果我们需要发送通知，那么就需要在不同的地方拿到通知的“频道”字符串（通知的名称），那么显然这个字符串是不能被轻易更改，而且可以在不同的地方获取。这个时候就需要定义一个外界可见的字符串常量。

推荐这样写：

```
//头文件
extern NSString *const ZOCCacheControllerDidClearCacheNotification;
//实现文件
static NSString * const ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";
static const CGFloat ZOCImageThumbnailHeight = 50.0f;
```
不推荐这样写：

```
#define CompanyName @"Apple Inc." 
#define magicNumber 42
```

### 宏
#### 1.宏、常量名都要使用大写字母，用下划线‘_’分割单词。

```
#define URL_GAIN_QUOTE_LIST @"/v1/quote/list"
#define URL_UPDATE_QUOTE_LIST @"/v1/quote/update"
#define URL_LOGIN  @"/v1/user/login”
```
#### 2. 宏定义中如果包含表达式或变量，表达式和变量必须用小括号括起来。

```
#define MY_MIN(A, B)  ((A)>(B)?(B):(A))
```

### 枚举
根据Objective-C的方式定义，根据官方SDK中的定义标准方式来定义枚举类型。（注：要对每个枚举类型进行注释，介绍该枚举类代表含义;枚举类型命名要加相关类名前缀并且枚举值命名要加枚举类型前缀.）

例：
  
```
  /*  用来设置动画的过渡效果 */
  typedef NS_ENUM(NSInteger, UIViewAnimationTransition) {
  		UIViewAnimationTransitionNone,///这个是正常的（也就是没有过渡效果）
		UIViewAnimationTransitionFlipFromLeft, ///从左向右翻转
		UIViewAnimationTransitionFlipFromRight, ///从右向左翻转
		UIViewAnimationTransitionCurlUp, ///从下向上卷(效果类似正着翻书)
		UIViewAnimationTransitionCurlDown,///从上向下卷（效果类似于反着翻书）
   };
```
### CGRect函数
其实iOS内部已经提供了相应的获取CGRect各个部分的函数了，它们的可读性比较高，而且简短，推荐使用：

推荐这样写：

```
CGRect frame = self.view.frame; 
CGFloat x = CGRectGetMinX(frame); 
CGFloat y = CGRectGetMinY(frame); 
CGFloat width = CGRectGetWidth(frame); 
CGFloat height = CGRectGetHeight(frame); 
CGRect frame = CGRectMake(0.0, 0.0, width, height);
```
而不是

```
CGRect frame = self.view.frame;  
CGFloat x = frame.origin.x;  
CGFloat y = frame.origin.y;  
CGFloat width = frame.size.width;  
CGFloat height = frame.size.height;  
CGRect frame = (CGRect){ .origin = CGPointZero, .size = frame.size };
```
### 泛型
建议在定义NSArray和NSDictionary时使用泛型，可以保证程序的安全性：

```
NSArray<NSString *> *testArr = [NSArray arrayWithObjects:@"Hello", @"world", nil];
NSDictionary<NSString *, NSNumber *> *dic = @{@"key":@(1), @"age":@(10)};
```
### Block
#### 为常用的Block类型创建typedef

如果我们需要重复创建某种block（相同参数，返回值）的变量，我们就可以通过typedef来给某一种块定义属于它自己的新类型

例如：

```
int (^variableName)(BOOL flag, int value) =^(BOOL flag, int value){
     // Implementation
     return someInt;
}
```
这个Block有一个bool参数和一个int参数，并返回int类型。我们可以给它定义类型：

```
int(^EOCSomeBlock)(BOOL flag, int value);
```
再次定义的时候，就可以通过简单的赋值来实现：

```
EOCSomeBlock block = ^(BOOL flag, int value){
// Implementation
};
```

#### 定义作为参数的Block：

```
(void)startWithCompletionHandler: (void(^)(NSData data, NSError error))completion;
```

这里的Block有一个NSData参数，一个NSError参数并没有返回值

```
typedef void(^EOCCompletionHandler)(NSData data, NSError error);

(void)startWithCompletionHandler:(EOCCompletionHandler)completion;
```
通过typedef定义Block签名的好处是:如果要某种块增加参数，那么只修改定义签名的那行代码即可。
### 字面量语法

尽量使用字面量值来创建 NSString , NSDictionary , NSArray , NSNumber 这些不可变对象：
推荐这样写：

```
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"}; 
NSNumber *shouldUseLiterals = @YES;NSNumber *buildingZIPCode = @10018;
```
不推荐这样写：

```
NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill" ];
NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];
```
### 属性
#### 1. 属性的命名使用小驼峰
推荐这样写：

```
@property (nonatomic, readwrite, strong) UIButton *confirmButton;
```
#### 2. 属性的关键字推荐按照 原子性，读写，内存管理的顺序排列
推荐这样写：

```
@property (nonatomic, readwrite, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *gender;
@property (nonatomic, readwrite, strong) UIView *headerView;
```
#### 3. Block属性应该使用copy关键字
推荐这样写：

```
typedef void (^ErrorCodeBlock) (id errorCode,NSString *message);
@property (nonatomic, readwrite, copy) ErrorCodeBlock errorBlock;//将block拷贝到堆中
```
#### 4. 形容词性的BOOL属性的getter应该加上is前缀
推荐这样写：

```
@property (assign, getter=isEditable) BOOL editable;
```
#### 5. 使用getter方法做懒加载
实例化一个对象是需要耗费资源的，如果这个对象里的某个属性的实例化要调用很多配置和计算，就需要懒加载它，在使用它的前一刻对它进行实例化：

```
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
           _dateFormatter = [[NSDateFormatter alloc] init];
           NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
           [_dateFormatter setLocale:enUSPOSIXLocale];
           [_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    } 
    return _dateFormatter;
}
```
但是也有对这种做法的争议：getter方法可能会产生某些副作用，例如如果它修改了全局变量，可能会产生难以排查的错误。

### 6. 除了init和dealloc方法，建议都使用点语法访问属性
使用点语法的好处：

setter：

- setter会遵守内存管理语义(strong, copy, weak)。
- 通过在内部设置断点，有助于调试bug。
- 可以过滤一些外部传入的值。
- 捕捉KVO通知。

getter：

- 允许子类化。
- 通过在内部设置断点，有助于调试bug。
- 实现懒加载（lazy initialization）。

注意：

懒加载的属性，必须通过点语法来读取数据。因为懒加载是通过重写getter方法来初始化实例变量的，如果不通过属性来读取该实例变量，那么这个实例变量就永远不会被初始化。

在init和dealloc方法里面使用点语法的后果是：因为没有绕过setter和getter，在setter和getter里面可能会有很多其他的操作。而且如果它的子类重载了它的setter和getter方法，那么就可能导致该子类调用其他的方法。

#### 7. 不要滥用点语法，要区分好方法调用和属性访问
推荐这样写：

```
view.backgroundColor = [UIColor orangeColor]; 
[UIApplication sharedApplication].delegate;
```
不推荐这样写：

```
[view setBackgroundColor:[UIColor orangeColor]]; 
UIApplication.sharedApplication.delegate;
```
#### 8. 尽量使用不可变对象
建议尽量把对外公布出来的属性设置为只读，在实现文件内部设为读写。具体做法是：

在头文件中，设置对象属性为 `readonly` 在实现文件中设置为`readwrite`。
这样一来，在外部就只能读取该数据，而不能修改它，使得这个类的实例所持有的数据更加安全。
而且，对于集合类的对象，更应该仔细考虑是否可以将其设为可变的。如果在公开部分只能设置其为只读属性，那么就在非公开部分存储一个可变型。所以当在外部获取这个属性时，获取的只是内部可变型的一个不可变版本,例如：

在公共API中：

```
@interface EOCPerson : NSObject

@property (nonatomic, copy, readonly) NSString firstName;
@property (nonatomic, copy, readonly) NSString lastName;
@property (nonatomic, strong, readonly) NSSet *friends //向外公开的不可变集合

- (id)initWithFirstName:(NSString)firstName andLastName:(NSString)lastName;
- (void)addFriend:(EOCPerson*)person;
- (void)removeFriend:(EOCPerson*)person;
@end
```
> 在这里，我们将friends属性设置为不可变的set。然后，提供了来增加和删除这个set里的元素的公共接口。
在实现文件里：

```
@interface EOCPerson ()

@property (nonatomic, copy, readwrite) NSString firstName;
@property (nonatomic, copy, readwrite) NSString lastName;

@end

@implementation EOCPerson {
NSMutableSet *_internalFriends; //实现文件里的可变集合
}

- (NSSet*)friends {
return [_internalFriends copy]; //get方法返回的永远是可变set的不可变型
}

- (void)addFriend:(EOCPerson*)person {
[_internalFriends addObject:person]; //在外部增加集合元素的操作
//do something when add element
}

- (void)removeFriend:(EOCPerson*)person {
[_internalFriends removeObject:person]; //在外部移除元素的操作
//do something when remove element
}

- (id)initWithFirstName:(NSString)firstName andLastName:(NSString)lastName {

if ((self = [super init])) {

_firstName = firstName;
_lastName = lastName;
_internalFriends = [NSMutableSet new];
}
return self;
}
```

我们可以看到，在实现文件里，保存一个可变set来记录外部的增删操作。
这里最重要的代码是：

```
- (NSSet*)friends {
return [_internalFriends copy];
}
```
> 这个是friends属性的获取方法：它将当前保存的可变set复制了一不可变的set并返回。因此，外部读取到的set都将是不可变的版本。

### 方法
#### 1. 方法名中不应使用and，而且签名要与对应的参数名保持高度一致
推荐这样写：

```
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;
```
不推荐这样写：

```
- (instancetype)initWithWidth:(CGFloat)width andHeight:(CGFloat)height;
- (instancetype)initWith:(int)width and:(int)height;
```
#### 2. 方法实现时，如果参数过长，则令每个参数占用一行，以冒号对齐。

```
- (void)doSomethingWith:(NSString *)theFoo
                   rect:(CGRect)theRect
               interval:(CGFloat)theInterval
{
   //Implementation
}
```
#### 3. 私有方法应该在实现文件中申明。

```
@interface ViewController ()
- (void)basicConfiguration;
@end
@implementation ViewController
- (void)basicConfiguration
{
   //Do some basic configuration
}
@end
```
#### 4. 方法名用小写字母开头的单词组合而成

```
- (NSString *)descriptionWithLocale:(id)locale;
```
#### 5. 方法名前缀
- 刷新视图的方法名要以refresh为首。
- 更新数据的方法名要以update为首。
推荐这样写：

```
- (void)refreshHeaderViewWithCount:(NSUInteger)count;
- (void)updateDataSourceWithViewModel:(ViewModel*)viewModel;
```
### 面向协议编程
如果某些功能（方法）具备可复用性，我们就需要将它们抽取出来放入一个抽象接口文件中（在iOS中，抽象接口即协议），让不同类型的对象遵循这个协议，从而拥有相同的功能。

因为协议是不依赖于某个对象的，所以通过协议，我们可以解开两个对象之间的耦合。如何理解呢？我们来看一下下面这个例子：

现在有一个需求：在一个UITableViewController里面拉取feed并展示出来。

方案一：
定义一个拉取feed的类ZOCFeedParser，这个类有一些代理方法实现feed相关功能：

```
@protocol ZOCFeedParserDelegate <NSObject>
@optional
- (void)feedParserDidStart:(ZOCFeedParser *)parser;
- (void)feedParser:(ZOCFeedParser *)parser didParseFeedInfo:(ZOCFeedInfoDTO *)info; 
- (void)feedParser:(ZOCFeedParser *)parser didParseFeedItem:(ZOCFeedItemDTO *)item; 
- (void)feedParserDidFinish:(ZOCFeedParser *)parser;
- (void)feedParser:(ZOCFeedParser *)parser didFailWithError:(NSError *)error;@end 
@interface ZOCFeedParser : NSObject
@property (nonatomic, weak) id <ZOCFeedParserDelegate> delegate; 
@property (nonatomic, strong) NSURL *url; 
- (id)initWithURL:(NSURL *)url; 
- (BOOL)start; 
- (void)stop; 
@end
```
然后在ZOCTableViewController里面传入ZOCFeedParser，并遵循其代理方法，实现feed的拉取功能。

```
@interface ZOCTableViewController : UITableViewController<ZOCFeedParserDelegate>
- (instancetype)initWithFeedParser:(ZOCFeedParser *)feedParser; 
@end
```
具体应用：

```
NSURL *feedURL = [NSURL URLWithString:@"http://bbc.co.uk/feed.rss"]; 
ZOCFeedParser *feedParser = [[ZOCFeedParser alloc] initWithURL:feedURL]; 
ZOCTableViewController *tableViewController = [[ZOCTableViewController alloc] initWithFeedParser:feedParser]; 
feedParser.delegate = tableViewController;
```
OK，现在我们实现了需求：在ZOCTableViewController里面存放了一个ZOCFeedParser对象来处理feed的拉取功能。

但这里有一个严重的耦合问题：ZOCTableViewController只能通过ZOCFeedParser对象来处理feed的拉取功能。
于是我们重新审视一下这个需求：其实我们实际上只需要ZOCTableViewController拉取feed就可以了，而具体是由哪个对象来拉取，ZOCTableViewController并不需要关心。

也就是说，我们需要提供给ZOCTableViewController的是一个更范型的对象，这个对象具备了拉取feed的功能就好了，而不应该仅仅局限于某个具体的对象（ZOCFeedParser）。所以，刚才的设计需要重新做一次修改：

方案二：
首先需要在一个接口文件ZOCFeedParserProtocol.h里面定义抽象的，具有拉取feed功能的协议：

```
@protocol ZOCFeedParserDelegate <NSObject>
@optional
- (void)feedParserDidStart:(id<ZOCFeedParserProtocol>)parser;
- (void)feedParser:(id<ZOCFeedParserProtocol>)parser didParseFeedInfo:(ZOCFeedInfoDTO *)info; 
- (void)feedParser:(id<ZOCFeedParserProtocol>)parser didParseFeedItem:(ZOCFeedItemDTO *)item; 
- (void)feedParserDidFinish:(id<ZOCFeedParserProtocol>)parser;
- (void)feedParser:(id<ZOCFeedParserProtocol>)parser didFailWithError:(NSError *)error;@end 
@protocol ZOCFeedParserProtocol <NSObject>
@property (nonatomic, weak) id <ZOCFeedParserDelegate> delegate; 
@property (nonatomic, strong) NSURL *url;
- (BOOL)start;
- (void)stop;
@end
```
而原来的ZOCFeedParser仅仅是需要遵循上面这个协议就具备了拉取feed的功能：

```
@interface ZOCFeedParser : NSObject <ZOCFeedParserProtocol> 
- (id)initWithURL:(NSURL *)url;//仅仅需要通过传入url即可，其他事情都交给ZOCFeedParserProtocol@end
而且，ZOCTableViewController也不直接依赖于ZOCFeedParser对象，我们只需要传给它一个遵循<ZOCFeedParserProtocol>的对象即可。

@interface ZOCTableViewController : UITableViewController <ZOCFeedParserDelegate>
- (instancetype)initWithFeedParser:(id<ZOCFeedParserProtocol>)feedParser;
@end
```
这样一来，ZOCTableViewController和ZOCFeedParser之间就没有直接的关系了。以后，如果我们想：

给这个feed拉取器增加新的功能：仅需要修改ZOCFeedParserProtocol.h文件。
更换一个feed拉取器实例：创建一个新类型来遵循ZOCFeedParserProtocol.h即可。

### iOS 中委托的设计
#### 1. 要区分好代理和数据源的区别
在iOS开发中的委托模式包含了delegate（代理）和datasource（数据源）。虽然二者同属于委托模式，但是这两者是有区别的。这个区别就是二者的信息流方向是不同的：

- delegate ：事件发生的时候，委托者需要通知代理。（信息流从委托者到代理）
- datasource：委托者需要从数据源拉取数据。（信息流从数据源到委托者）

然而包括苹果也没有做好榜样，将它们彻底的区分开。就拿UITableView来说，在它的delegate方法中有一个方法：

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
```
这个方法正确地体现了代理的作用：委托者（tableview）告诉代理（控制器）“我的某个cell被点击了”。但是，UITableViewDelegate的方法列表里还有这个方法：

```
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
```
该方法的作用是 由控制器来告诉tabievlew的行高，也就是说，它的信息流是从控制器（数据源）到委托者（tableview）的。准确来讲，它应该是一个数据源方法，而不是代理方法。

在UITableViewDataSource中，就有标准的数据源方法：

```
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
这个方法的作用就是让tableview向控制器拉取一个section数量的数据。
```
所以，在我们设计一个视图控件的代理和数据源时，一定要区分好二者的区别，合理地划分哪些方法属于代理方法，哪些方法属于数据源方法。

#### 2. 代理方法的第一个参数必须为委托者
代理方法必须以委托者作为第一个参数（参考UITableViewDelegate）的方法。其目的是为了区分不同委托着的实例。因为同一个控制器是可以作为多个tableview的代理的。若要区分到底是哪个tableview的cell被点击了，就需要在`- (void)tableView:(UITableView )tableView didSelectRowAtIndexPath:(NSIndexPath )indexPath`方法中做个区分。

#### 3.向代理发送消息时需要判断其是否实现该方法
在委托着向代理发送消息的时候，需要判断委托着是否实现了这个代理方法:

```
if ([self.delegate respondsToSelector:@selector(signUpViewControllerDidPressSignUpButton:)]) { 
 [self.delegate signUpViewControllerDidPressSignUpButton:self]; 
}
```
#### 4. 遵循代理过多的时候，换行对齐显示

```
@interface ShopViewController () <UIGestureRecognizerDelegate,
                                  HXSClickEventDelegate,
                                  UITableViewDelegate,
                                  UITableViewDataSource>
```
#### 5. 代理的方法需要明确必须执行和可不执行
代理方法在默认情况下都是必须执行的，然而在设计一组代理方法的时候，有些方法可以不是必须执行（是因为存在默认配置），这些方法就需要使用@optional关键字来修饰：

```
@protocol ZOCServiceDelegate <NSObject>
@optional
- (void)generalService:(ZOCGeneralService *)service didRetrieveEntries:(NSArray *)entries; 
@end
```
### 类
#### 1. 类的名称应该以多个大写字母为前缀；创建子类的时候，应该把代表子类特点的部分放在前缀和父类名的中间
推荐这样写：

```
//父类
ZOCSalesListViewController
//子类
ZOCDaySalesListViewController
ZOCMonthSalesListViewController
```
#### 2. initializer && dealloc

##### 2.1 dealloc方法里面应该直接访问实例变量，不应该用点语法访问
##### 2.2 init方法的写法：
init方法返回类型必须是instancetype，不能是id。
必须先实现[super init]。

```
- (instancetype)init { 
    self = [super init]; // call the designated initializer 
    if (self) { 
        // Custom initialization 
    } 
    return self; 
}
```

#### 3. 所有返回类对象和实例对象的方法都应该使用instancetype
将instancetype关键字作为返回值的时候，可以让编译器进行类型检查，同时适用于子类的检查，这样就保证了返回类型的正确性（一定为当前的类对象或实例对象）

推荐这样写：

```
@interface ZOCPerson
+ (instancetype)personWithName:(NSString *)name; 
@end
```
不推荐这样写：

```
@interface ZOCPerson
+ (id)personWithName:(NSString *)name; 
@end
```
#### 4. 在类的头文件中尽量少引用其他头文件
有时，类A需要将类B的实例变量作为它公共API的属性。这个时候，我们不应该引入类B的头文件，而应该使用向前声明（forward declaring）使用class关键字，并且在A的实现文件引用B的头文件。

```
// EOCPerson.h
#import <Foundation/Foundation.h>
@class EOCEmployer;
@interface EOCPerson : NSObject
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, strong) EOCEmployer *employer;//将EOCEmployer作为属性
@end
// EOCPerson.m
#import "EOCEmployer.h"
```
这样做有什么优点呢：

不在A的头文件中引入B的头文件，就不会一并引入B的全部内容，这样就减少了编译时间。
可以避免循环引用：因为如果两个类在自己的头文件中都引入了对方的头文件，那么就会导致其中一个类无法被正确编译。

但是个别的时候，必须在头文件中引入其他类的头文件:

主要有两种情况：

- 该类继承于某个类，则应该引入父类的头文件。
- 该类遵从某个协议，则应该引入该协议的头文件。而且最好将协议单独放在一个头文件中。

#### 5. 类的布局

```
#pragma mark - Life Cycle Methods
- (instancetype)init
- (void)dealloc
- (void)viewWillAppear:(BOOL)animated
- (void)viewDidAppear:(BOOL)animated
- (void)viewWillDisappear:(BOOL)animated
- (void)viewDidDisappear:(BOOL)animated
#pragma mark - Override Methods
#pragma mark - Intial Methods
#pragma mark - Network Methods
#pragma mark - Target Methods
#pragma mark - Public Methods
#pragma mark - Private Methods
#pragma mark - DataSource  
#pragma mark - Delegate  
#pragma mark - Lazy Loads
#pragma mark - NSCopying  
#pragma mark - NSObject  Methods
```

```
#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleDone target:self action:@selector(reload)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    [self.view addSubview:self.webView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"didStartProvisionalNavigation---%@", navigation);
}

#pragma mark - WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return [[WKWebView alloc] init];
}

#pragma mark - private method
- (void)reload
{
    [self.webView reload];
}

- (void)save
{
    NSString *lJs = @"document.documentElement.innerHTML";
    [self.webView evaluateJavaScript:lJs completionHandler:^(id _Nullable str, NSError * _Nullable error) {
        NSLog(@"%@", str);
    }];
}

#pragma mark - Lazy Loads
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor yellowColor];
    }
    return _webView;
}

@end
```
### 分类
#### 1. 分类添加的方法需要添加前缀和下划线
推荐这样写：

```
@interface NSDate (ZOCTimeExtensions)
 - (NSString *)zoc_timeAgoShort;
@end
```
不推荐这样写：

```
@interface NSDate (ZOCTimeExtensions) 
- (NSString *)timeAgoShort;
@end
```
#### 2. 把类的实现代码分散到便于管理的多个分类中
一个类可能会有很多公共方法，而且这些方法往往可以用某种特有的逻辑来分组。我们可以利用Objecctive-C的分类机制，将类的这些方法按一定的逻辑划入几个分区中。

先看一个没有使用无分类的类：

```
#import <Foundation/Foundation.h>
@interface EOCPerson : NSObject
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSArray *friends;
- (id)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName;
/* Friendship methods */
- (void)addFriend:(EOCPerson*)person;
- (void)removeFriend:(EOCPerson*)person;
- (BOOL)isFriendsWith:(EOCPerson*)person;
/* Work methods */
- (void)performDaysWork;
- (void)takeVacationFromWork;
/* Play methods */
- (void)goToTheCinema;
- (void)goToSportsGame;
@end
```
分类之后：

```
#import <Foundation/Foundation.h>
@interface EOCPerson : NSObject
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSArray *friends;
- (id)initWithFirstName:(NSString*)firstName
andLastName:(NSString*)lastName;
@end
@interface EOCPerson (Friendship)
- (void)addFriend:(EOCPerson*)person;
- (void)removeFriend:(EOCPerson*)person;
- (BOOL)isFriendsWith:(EOCPerson*)person;
@end
@interface EOCPerson (Work)
- (void)performDaysWork;
- (void)takeVacationFromWork;
@end
@interface EOCPerson (Play)
- (void)goToTheCinema;
- (void)goToSportsGame;
@end
```
其中，FriendShip分类的实现代码可以这么写：

```
// EOCPerson+Friendship.h
#import "EOCPerson.h"
@interface EOCPerson (Friendship)
- (void)addFriend:(EOCPerson*)person;
- (void)removeFriend:(EOCPerson*)person;
- (BOOL)isFriendsWith:(EOCPerson*)person;
@end
// EOCPerson+Friendship.m
#import "EOCPerson+Friendship.h"
@implementation EOCPerson (Friendship)
- (void)addFriend:(EOCPerson*)person {
 /* ... */
}
- (void)removeFriend:(EOCPerson*)person {
 /* ... */
}
- (BOOL)isFriendsWith:(EOCPerson*)person {
 /* ... */
}
@end
```
注意：在新建分类文件时，一定要引入被分类的类文件。

通过分类机制，可以把类代码分成很多个易于管理的功能区，同时也便于调试。因为分类的方法名称会包含分类的名称，可以马上看到该方法属于哪个分类中。

利用这一点，我们可以创建名为Private的分类，将所有私有方法都放在该类里。这样一来，我们就可以根据private一词的出现位置来判断调用的合理性，这也是一种编写“自我描述式代码（self-documenting）”的办法。

### 单例
#### 1. 单例不能作为容器对象来使用
单例对象不应该暴露出任何属性，也就是说它不能作为让外部存放对象的容器。它应该是一个处理某些特定任务的工具，比如在iOS中的GPS和加速度传感器。我们只能从他们那里得到一些特定的数据。

#### 2. 使用dispatch_once来生成单例
推荐这样写：

```
+ (instancetype)sharedInstance { 
 static id sharedInstance = nil; 
 static dispatch_once_t onceToken = 0;
       dispatch_once(&onceToken, ^{ 
  sharedInstance = [[self alloc] init];
  }); 
 return sharedInstance; 
}
```
不推荐这样写：

```
+ (instancetype)sharedInstance { 
 static id sharedInstance; 
 @synchronized(self) { 
 if (sharedInstance == nil) { 
  	sharedInstance = [[MyClass alloc] init]; 
 } } 
 return sharedInstance; 
}
```
### 相等性的判断
判断两个person类是否相等的合理做法：

```
-  (BOOL)isEqual:(id)object {
    if (self == object) {  
    	return YES; //判断内存地址
 	 } 
  	 if (![object isKindOfClass:[ZOCPerson class]]) { 
     	return NO; //是否为当前类或派生类 
  	 } 
 	return [self isEqualToPerson:(ZOCPerson *)object]; 
}

//自定义的判断相等性的方法
-  (BOOL)isEqualToPerson:(Person *)person { 
      if (!person) {  
      		return NO;
  	   } 
  	   BOOL namesMatch = (!self.name && !person.name) || [self.name isEqualToString:person.name]; 
  	   BOOL birthdaysMatch = (!self.birthday && !person.birthday) || [self.birthday isEqualToDate:person.birthday]; 
  	   return haveEqualNames && haveEqualBirthdays; 
}
```

### 多用队列，少用同步锁来避免资源抢夺
多个线程执行同一份代码时，很可能会造成数据不同步。建议使用GCD来为代码加锁的方式解决这个问题。

方案一：使用串行同步队列来将读写操作都安排到同一个队列里：

```
_syncQueue = dispatch_queue_create("com.effectiveobjectivec.syncQueue", NULL);
//读取字符串
- (NSString*)someString {
         __block NSString *localSomeString;
         dispatch_sync(_syncQueue, ^{
            localSomeString = _someString;
        });
         return localSomeString;
}
//设置字符串
- (void)setSomeString:(NSString*)someString {
     dispatch_sync(_syncQueue, ^{
        _someString = someString;
    });
}
```
这样一来，读写操作都在串行队列进行，就不容易出错。

但是，还有一种方法可以让性能更高：

方案二：将写操作放入栅栏快中，让他们单独执行；将读取操作并发执行。

```
_syncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//读取字符串
- (NSString*)someString {
     __block NSString *localSomeString;
     dispatch_sync(_syncQueue, ^{
        localSomeString = _someString;
    });
     return localSomeString;
}
//设置字符串
- (void)setSomeString:(NSString*)someString {
     dispatch_barrier_async(_syncQueue, ^{
        _someString = someString;
    });
}
```
显然，数据的正确性主要取决于写入操作，那么只要保证写入时，线程是安全的，那么即便读取操作是并发的，也可以保证数据是同步的。
这里的dispatch_barrier_async方法使得操作放在了同步队列里“有序进行”，保证了写入操作的任务是在串行队列里。

### NSArray & NSMutableArray
1. addObject之前要非空判断。
2. 取下标的时候要判断是否越界。
3. 取第一个元素或最后一个元素的时候使用firtstObject和lastObject

### NSCache
#### 1. 构建缓存时选用NSCache 而非NSDictionary
如果我们缓存使用得当，那么应用程序的响应速度就会提高。只有那种“重新计算起来很费事的数据，才值得放入缓存”，比如那些需要从网络获取或从磁盘读取的数据。

在构建缓存的时候很多人习惯用NSDictionary或者NSMutableDictionary，但是作者建议大家使用NSCache，它作为管理缓存的类，有很多特点要优于字典，因为它本来就是为了管理缓存而设计的。

#### 2. NSCache优于NSDictionary的几点：
- 当系统资源将要耗尽时，NSCache具备自动删减缓冲的功能。并且还会先删减“最久未使用”的对象。
- NSCache不拷贝键，而是保留键。因为并不是所有的键都遵从拷贝协议（字典的键是必须要支持拷贝协议的，有局限性）。
- NSCache是线程安全的：不编写加锁代码的前提下，多个线程可以同时访问NSCache。

### NSNotification
#### 1. 通知的名称
建议将通知的名字作为常量，保存在一个专门的类中：

```
// Const.h
extern NSString * const ZOCFooDidBecomeBarNotification
// Const.m
NSString * const ZOCFooDidBecomeBarNotification = @"ZOCFooDidBecomeBarNotification";
```
#### 2. 通知的移除
通知必须要在对象销毁之前移除掉。

## 其他
### 1. Xcode工程文件的物理路径要和逻辑路径保持一致。
### 2. 图片文件都放到 Assets.xcassets 中
### 3. 合理使用 pch 文件
首先需要了解的是 pch 本来的目的是在里面定义需要预编译的头文件。

而预编译头文件，顾名思义，是将头文件事先编译成一种二进制的中间格式。在整个编译过程中，只编译一次，并且会有缓存，如预编译头所涉及的部分不发生改变的话，在随后的编译过程中此部分不会重新进行编译，从而大大提高编译速度。

与此同时加入pch中的头文件，在项目其他地方要使用时，就不需要再import了。这可以算是一种便利，但它也是副作用的源头。

<font color='red'>切记：<b>pch的目的是提高编译速度，而不是让你少打几行import代码。</b></font>

由于程序员的滥用苹果在 XCode6 之后就不再生成 pch 文件了。。

当然在合理使用的情况下还是可以使用的，但加入到 pch 中必须满足以下条件

- 基本大多数文件都会用到。
- 不应该经常改动，比如宏定义、常量定义等不应该放在pch里，pch应该只有`#import`或者`#include`。

### 4. 忽略没有使用变量的编译警告
对于某些暂时不用，以后可能用到的临时变量，为了避免警告，我们可以使用如下方法将这个警告消除：

```
- (NSInteger)giveMeFive { 
 NSString *foo; 
 #pragma unused (foo) 
 return 5; 
}
```

### 5. 手动标明警告和错误
手动明确一个错误：

```
- (NSInteger)divide:(NSInteger)dividend by:(NSInteger)divisor { 
 #error Whoa, buddy, you need to check for zero here! 
 return (dividend / divisor); 
}
```
手动明确一个警告：

```
- (float)divide:(float)dividend by:(float)divisor { 
 #warning Dude, don't compare floating point numbers like this! 
 if (divisor != 0.0) { 
  return (dividend / divisor); 
 } else {  return NAN; 
 } 
}
```