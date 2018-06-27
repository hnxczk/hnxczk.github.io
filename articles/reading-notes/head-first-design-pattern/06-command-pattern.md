# 命令模式
一个餐厅点餐的交互过程
1. 客户创建订单
2. 订单封装了准备餐点的请求
3. 女招待的工作是接受订单，然后调用订单的 orderUp() 方法
4. 厨师具备具体准备餐点的能力
![](./images/06-command-pattern-1.png)

抽象出来命令模式
![](./images/06-command-pattern-2.png)

