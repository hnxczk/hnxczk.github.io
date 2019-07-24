# MDN 前端合集

最近花了一段时间将 MDN 上面 CSS 和 JavaScript 相关教程整体看了一遍，整理成了下面这两个思维导图。

在整理的过程中基本上按照 MDN 上面的大纲进行的。并修改了部分内容的顺序以适应思维导图的样式。

源文件在这里 [CSS](./source/CSS.xmind) 、[JavaScript](./source/JavaScript.xmind)。 需要用 [XMind ZEN](https://www.xmind.cn/zen/) 打开(试用版完全够用)。

## 总结

### CSS

CSS 相对于 JS 来说相对简单一点。结合学习和使用的情况，下面列出了一些我认为的几个重点内容以供参考。

#### 1. CSS 选择器

主要指选择器的语法以及层叠与继承。了解了这些以后可以用更少的代码实现一些特殊的需求。

#### 2. 盒子模型

包括盒子模型的定义、属性。这些可以帮助理解一些看起来比较“异常”的现象。比如设置宽高属性无效一般都是因为父类的宽高没有确定等等问题（别问我为啥知道 😭）

#### 3. 布局

我认为这个是最重要的内容，也是我最初比较疑惑的内容。了解这些有助于实现一些比较特殊的布局要求。

下面这个图片很清晰的演示了 flex 布局相关属性

![flex 布局](./images/flex.jpeg)

补充一点，对齐是刚开始使用 CSS 的时候比较疑惑的一点，尤其是竖直方向上的。flex 布局的居中相对简单，position 布局的居中不太好写。这里提供一个比较方便实现对齐的方法（来自 Stack Overflow）。

```
// 水平
left: 50%;
transform: translateX(-50%);

// 竖直
top: 50%;
transform: translateY(-50%);

// 同时居中
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
```

#### 4. 样式

包括文本和盒子的样式，也用于实现 UI 设计的一些“苛刻”的要求😂。。。

### JS

本来 JS 这块儿要按照根据编程语言的一般定义（用一定的词法和语法，表达一定语义，操作运行时）来整理的，但是进行了一半之后发现 MDN 上面的教程不能完全按照这个进行划分，重新整理的话要耗费额外的精力，反而耽误了效率。因此下面的这个图按照 [JavaScript 指南
](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide) 划分的章节进行整理，部分细节做了微调。

下面列一些关键点

#### 1. JavaScript 语句后应该加分号么？

个人倾向于不加分号，在以 ([/+- 开头的语句前加分号。

具体可以参考以下资料 
1. [知乎上贺师俊的回答](https://www.zhihu.com/question/20298345/answer/14670020)
2. [JS魔法堂：ASI (自动分号插入机制) 和前置分号](https://www.cnblogs.com/fsjohnhuang/p/4154503.html)

#### 2. 计算为 false 的值

false、undefined、null、0、NaN、空字符串（""）

这一点是在使用条件语句以及逻辑判断的时候很有必要了解的内容

#### 3. 逻辑运算符

逻辑运算符返回的并不一定是 true 或者 false

![](./images/js_logic.png)

#### 4. 遍历数组不要使用 for...in

for...in 也会遍历数组对象的属性

#### 5. Map 中的键值是有序的，而添加到对象中的键则不是。

## TODO

### CSS 
1. CSS Grid 
2. CSS 动画

### JS

1. ~~内存管理~~
2. ~~事件循环~~

## CSS
![](./images/CSS.png)

## JS

![](./images/JavaScript.png)