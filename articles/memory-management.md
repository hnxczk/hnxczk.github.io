# 内存管理基础
## 程序可执行文件的结构
一个程序的可执行文件在内存中的结果，从大的角度可以分为两个部分：**只读部分**和**可读写部分**。
### 只读部分
- 程序代码（.text）
- 程序中的常量（.rodata）

### 可读写部分
- .data： 初始化了的全局变量和静态变量
- .bss： 即 Block Started by Symbol， 未初始化的全局变量和静态变量（这个我感觉上课真的没讲过啊我去。。。）
- heap： 堆，使用 malloc, realloc, 和 free 函数控制的变量，堆在所有的线程，共享库，和动态加载的模块中被共享使用
- stack： 栈，函数调用时使用栈来保存函数现场，自动变量（即生命周期限制在某个 scope 的变量）也存放在栈中。

## data 和 bss 区
他们都是用来存储全局变量和静态变量的，区别在于 data 区存放的是初始化过的， bss 区存放的是没有初始化过的。

### 静态变量和全局变量
这两个概念都是很常见的概念，又经常在一起使用，很容易造成混淆。

#### 全局变量：
在一个代码文件（具体说应该一个 translation unit/compilation unit)）当中，一个变量要么定义在函数中，要么定义在在函数外面。当定义在函数外面时，这个变量就有了全局作用域，成为了全局变量。全局变量不光意味着这个变量可以在整个文件中使用，也意味着这个变量可以在其他文件中使用（这种叫做 external linkage）。

#### 静态变量： 
指使用 static 关键字修饰的变量，static 关键字对变量的作用域进行了限制，具体的限制如下：

- 在函数外定义：全局变量，但是只在当前文件中可见（叫做 internal linkage）
- 在函数内定义：全局变量，但是只在此函数内可见（同时，在多次函数调用中，变量的值不会丢失）
- (C++）在类中定义：全局变量，但是只在此类中可见

对于全局变量来说，为了避免全局变量的重复定义错误，我们可以在一个文件中使用 static，另一个不使用。这样使用 static 的就会使用自己的 a 变量，而没有用 static 的会使用全局的 a 变量。当然，最好两个都使用 static，避免更多可能的命名冲突。

**注意：** '静态'这个中文翻译实在是有些莫名其妙，给人的感觉像是不可改变的，而实际上 static 跟不可改变没有关系，它只代表所修饰变量的作用域范围。而不可改变的变量使用 const 关键字修饰，注意不要混淆。

### extern：
extern 是 C 语言中另一个关键字，用来指示变量或函数的定义在别的文件中，使用 extern 可以在多个源文件中共享某个变量.

## 栈
栈是用于存放本地变量，内部临时变量以及有关上下文的内存区域。程序在调用函数时，操作系统会自动通过压栈和弹栈完成保存函数现场等操作，不需要程序员手动干预。

栈是一块连续的内存区域，栈顶的地址和栈的最大容量是系统预先规定好的。能从栈获得的空间较小。如果申请的空间超过栈的剩余空间时，例如递归深度过深，将提示 stackoverflow (栈溢出)。

栈是机器系统提供的数据结构，计算机会在底层对栈提供支持：分配专门的寄存器存放栈的地址，压栈出栈都有专门的指令执行，这就决定了栈的效率比较高。

## 堆
堆是用于存放除了栈里的东西之外所有其他东西的内存区域，当使用 malloc 和 free 时就是在操作堆中的内存。对于堆来说，释放工作由程序员控制，容易产生 memory leak。

堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。

对于堆来讲，频繁的 new/delete 势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低。对于栈来讲，则不会存在这个问题，因为栈是先进后出的队列，永远都不可能有一个内存块从栈中间弹出。

堆都是动态分配的，没有静态分配的堆。栈有2种分配方式：静态分配和动态分配。静态分配是编译器完成的，比如局部变量的分配。动态分配由 alloca 函数进行分配，但是栈的动态分配和堆是不同的，他的动态分配是由编译器进行释放，无需我们手工实现。

计算机底层并没有对堆的支持，堆则是 C/C++ 函数库提供的，同时由于上面提到的碎片问题，都会导致堆的效率比栈要低。