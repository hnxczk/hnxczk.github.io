# JavaScript 学习记录
## 1. Mac 上 Chrome 打开“开发者工具”:	⌘ + Option + i [Chrome 键盘快捷键](https://support.google.com/chrome/answer/157179?hl=zh-Hans)

## 2. 由于浏览器的安全限制，以 file:// 开头的地址无法执行如联网等JavaScript代码，最终，你还是需要架设一个Web服务器，然后以 http:// 开头的地址来正常执行所有JavaScript代码。

## 3. JavaScript并不强制要求在每个语句的结尾加 ; ，浏览器中负责执行JavaScript代码的引擎会自动在每个语句的结尾补上 ; 。

## 4. Number 类型
### NaN
 NaN 表示 Not a Number，当无法计算结果时用NaN表示.这个特殊的Number与所有其他值都不相等，包括它自己：   
```
NaN === NaN; // false
```

唯一能判断NaN的方法是通过isNaN()函数：

```
isNaN(NaN); // true
```

### Infinity
Infinity 表示无限大，当数值超过了 JavaScript 的 Number 所能表示的最大值时，就表示为 Infinity 

## 5.字符串是以单引号'或双引号"括起来的任意文本

## 6. == 与 ===

- ==比较，它会自动转换数据类型再比较，很多时候，会得到非常诡异的结果；

- ===比较，它不会自动转换数据类型，如果数据类型不一致，返回false，如果一致，再比较。

由于JavaScript这个设计缺陷，**不要使用 == 比较，始终坚持使用 === 比较。**

## 7. 注意浮点数的相等比较

```
1 / 3 === (1 - 2 / 3); // false
```
这不是JavaScript的设计缺陷。浮点数在运算过程中会产生误差，因为计算机无法精确表示无限循环小数。要比较两个浮点数是否相等，只能计算它们之差的绝对值，看是否小于某个阈值：

```
Math.abs(1 / 3 - (1 - 2 / 3)) < 0.0000001; // true
```

## 8. 大多数情况下，我们都应该用null。undefined仅仅在判断函数参数是否传递的情况下有用。

## 9. 对象
JavaScript 的对象是一组由键-值组成的无序集合. 对象的键都是字符串类型，值可以是任意数据类型。

```
var person = {
    name: 'Bob',
    age: 20,
    tags: ['js', 'web', 'mobile'],
    city: 'Beijing',
    hasCar: true,
    zipcode: null
};
```
## 10. JavaScript 是动态类型语言 
在 JavaScript 中，使用等号=对变量进行赋值。可以把任意数据类型赋值给变量，同一个变量可以反复赋值，而且可以是不同类型的变量，但是要注意只能用var申明一次。

## 11.如果一个变量没有通过var申明就被使用，那么该变量就自动被申明为全局变量

## 12. strict 模式：在strict模式下运行的JavaScript代码，强制通过var申明变量，未使用var申明变量就使用的，将导致运行错误。

## 13. 启用strict模式的方法是在JavaScript代码的第一行写上：'use strict';

## 14. 如果字符串内部既包含'又包含"怎么办？可以用转义字符\来标识，比如：'I\'m \"OK\"!';

## 15. 由于多行字符串用\n写起来比较费事，所以最新的ES6标准新增了一种多行字符串的表示方法，用反引号 ` `(键盘上数字1左边的键) 表示：

```
`这是一个
多行
字符串`;
```

## 16. 需要特别注意的是，字符串是不可变的，如果对字符串的某个索引赋值，不会有任何错误，但是，也没有任何效果.

```
var s = 'Test';
s[0] = 'X';
alert(s); // s仍然为'Test'
```

## 17. JavaScript 为字符串提供了一些常用方法，注意，调用这些方法本身不会改变原有字符串的内容，而是返回一个新字符串.

## 18. 直接给 Array 的 length 赋一个新的值会导致 Array 大小的变化

## 19. 如果通过索引赋值时，索引超过了范围，同样会引起 Array 大小的变化：

```
var arr = [1, 2, 3];
arr[5] = 'x';
arr; // arr变为[1, 2, 3, undefined, undefined, 'x']
```

## 20. 如果不给 slice() 传递任何参数，它就会从头到尾截取所有元素。利用这一点，我们可以很容易地复制一个Array：

## 21. 如果要往 Array 的头部添加若干元素，使用 unshift() 方法，shift() 方法则把 Array 的第一个元素删掉：

## 22. push() 向 Array 的末尾添加若干元素，pop() 则把Array的最后一个元素删除掉：

## 23. splice()方法是修改Array的“万能方法”，它可以从指定的索引开始删除若干元素，然后再从该位置添加若干元素：

```
var arr = ['Microsoft', 'Apple', 'Yahoo', 'AOL', 'Excite', 'Oracle'];
// 从索引2开始删除3个元素,然后再添加两个元素:
arr.splice(2, 3, 'Google', 'Facebook'); // 返回删除的元素 ['Yahoo', 'AOL', 'Excite']
arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
// 只删除,不添加:
arr.splice(2, 2); // ['Google', 'Facebook']
arr; // ['Microsoft', 'Apple', 'Oracle']
// 只添加,不删除:
arr.splice(2, 0, 'Google', 'Facebook'); // 返回[],因为没有删除任何元素
arr; // ['Microsoft', 'Apple', 'Google', 'Facebook', 'Oracle']
```

## 24. 对象访问属性是通过.操作符完成的，但这要求属性名必须是一个有效的变量名。如果属性名包含特殊字符，就必须用''括起来

```
var xiaohong = {
    name: '小红',
    'middle-school': 'No.1 Middle School'
};
```

xiaohong的属性名middle-school不是一个有效的变量，就需要用''括起来。访问这个属性也无法使用.操作符，必须用['xxx']来访问：

```
xiaohong['middle-school']; // 'No.1 Middle School'
xiaohong['name']; // '小红'
xiaohong.name; // '小红'
```

## 25. 如果我们要检测 xiaoming 对象是否拥有某一属性，可以用 in 操作符

## 26. 要判断一个属性是否是xiaoming自身拥有的，而不是继承得到的，可以用 hasOwnProperty() 方法

## 27. toString定义在object对象中，而所有对象最终都会在原型链上指向object

## 28. for ... in 对 Array 的循环得到的是 String 而不是其他

## 29. JavaScript 允许传入任意个参数而不影响调用，因此传入的参数比定义的参数多也没有问题，虽然函数内部并不需要这些参数

## 30. 利用 arguments，你可以获得调用者传入的所有参数。也就是说，即使函数不定义任何参数，还是可以拿到参数的值

## 31. 为了获取除了已定义参数之外的参数引入了rest参数，rest参数只能写在最后，前面用...标识，从运行结果可知，传入的参数先绑定已定义参数，多余的参数以数组形式交给变量rest。

## 32. 如果传入的参数连正常定义的参数都没填满，也不要紧，rest参数会接收一个空数组（注意不是undefined）

## 33. 变量提升 JavaScript的函数定义有个特点，它会先扫描整个函数体的语句，把所有申明的变量“提升”到函数顶部：，即可以定义在后面，使用在前面。但是会被初始化为 undefined

## 34. 不在任何函数内定义的变量就具有全局作用域。实际上，JavaScript默认有一个全局对象window，全局作用域的变量实际上被绑定到window的一个属性：

## 35. 全局定义的函数跟变量一样也会绑定到window上，比如 alert 就是一个绑定到 window 上的全局函数。

## 36. JavaScript实际上只有一个全局作用域。任何变量（函数也视为变量），如果没有在当前函数作用域中找到，就会继续往上查找，最后如果在全局作用域中也没有找到，则报ReferenceError错误。

## 37. 为了解决块级作用域，ES6引入了新的关键字let，用let替代var可以申明一个块级作用域的变量

## 38. ES6标准引入了新的关键字const来定义常量，const与let都具有块级作用域

## 39. 解构赋值

```
var [x, y, z] = ['hello', 'JavaScript', 'ES6'];

let [x, [y, z]] = ['hello', ['JavaScript', 'ES6']];

let [, , z] = ['hello', 'JavaScript', 'ES6']; // 忽略前两个元素，只对z赋值第三个元素

var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678',
    school: 'No.4 middle school'
};
var {name, age, passport} = person; // name, age, passport分别被赋值为对应属性:

var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678',
    school: 'No.4 middle school',
    address: {
        city: 'Beijing',
        street: 'No.1 Road',
        zipcode: '100001'
    }
};
var {name, address: {city, zip}} = person;
name; // '小明'
city; // 'Beijing'
zip; // undefined, 因为属性名是zipcode而不是zip
// 注意: address不是变量，而是为了让city和zip获得嵌套的address对象的属性:
address; // Uncaught ReferenceError: address is not defined

// 使用解构赋值对对象属性进行赋值时，如果对应的属性不存在，变量将被赋值为undefined，这和引用一个不存在的属性获得undefined是一致的。如果要使用的变量名和属性名不一致，可以用下面的语法获取：
var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678',
    school: 'No.4 middle school'
};

// 把passport属性赋值给变量id:
let {name, passport:id} = person;
name; // '小明'
id; // 'G-12345678'
// 注意: passport不是变量，而是为了让变量id获得passport属性:
passport; // Uncaught ReferenceError: passport is not defined


var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678'
};

// 如果person对象没有single属性，默认赋值为true:
var {name, single=true} = person;
name; // '小明'
single; // true
```

## 40. 有些时候，如果变量已经被声明了，再次赋值的时候，正确的写法也会报语法错误：

```
// 声明变量:
var x, y;
// 解构赋值:
{x, y} = { name: '小明', x: 100, y: 200};
// 语法错误: Uncaught SyntaxError: Unexpected token =
```
这是因为JavaScript引擎把{开头的语句当作了块处理，于是=不再合法。解决方法是用小括号括起来：

```
({x, y} = { name: '小明', x: 100, y: 200}); 
```

## 41. JavaScript的所有对象都是动态的，即使内置的函数，我们也可以重新指向新的函数。

现在假定我们想统计一下代码一共调用了多少次parseInt()，可以把所有的调用都找出来，然后手动加上count += 1，不过这样做太傻了。最佳方案是用我们自己的函数替换掉默认的parseInt()：

```
'use strict';

var count = 0;
var oldParseInt = parseInt; // 保存原函数

window.parseInt = function () {
    count += 1;
    return oldParseInt.apply(null, arguments); // 调用原函数
};
```

## 42. 