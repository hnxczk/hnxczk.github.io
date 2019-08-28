
module.exports = {
    title: '周小可',
    description: '实践不仅是检验真理的标准，而且是唯一的标准。',
    base: '/blog/', // 这是部署到github相关的配置
    markdown: {
        lineNumbers: false // 代码块显示行号
    },
    themeConfig: {
        nav: [
            {
                text: 'iOS',
                items: [
                    { text: 'GCD', link: '/articles/gcd/' },
                    { text: 'iOS中的锁', link: '/articles/locks/' },
                    { text: '性能优化', link: '/articles/performance-optimization/' },
                    { text: '事件响应', link: '/articles/responder/' },
                    { text: '图片编解码', link: '/articles/image_decode/' },
                    { text: 'NSHashTable 和 NSMapTable', link: '/articles/nshashtable-nsmaptable/' },
                    { text: '图文混排与 DTCoreText', link: '/articles/dttext/' },
                    { text: 'MVVM 实战', link: '/articles/mvvm/' },
                    { text: 'InfiniteTree', link: 'https://github.com/hnxczk/InfiniteTree' },
                    { text: 'ScrollViewAutoAdjust', link: 'https://github.com/hnxczk/ScrollViewAutoAdjust' },
                    { text: 'Instruments 分析', link: '/articles/instruments/' },
                    { text: '笔记', link: '/articles/note/' },
                ]
            },
            {
                text: '前端',
                items: [
                    { text: 'MDN 学习笔记', link: '/articles/mdn/' },
                    { text: 'JavaScript 类型', link: '/articles/reading-notes/geekbang-winter/03/' },
                    { text: 'JavaScript 对象和原型链', link: '/articles/reading-notes/geekbang-winter/04/' },
                    { text: 'JavaScript 执行上下文和执行栈', link: '/articles/reading-notes/geekbang-winter/05/' },
                    { text: 'JavaScript 作用域链与闭包', link: '/articles/reading-notes/geekbang-winter/06/' },
                ]
            },
            {
                text: '读书笔记',
                items: [
                    { text: 'Head First 设计模式', link: '/articles/reading-notes/head-first-design-pattern/' },
                    { text: '图说设计模式', link: '/articles/reading-notes/Graphic-Design-Patterns/' },
                    { text: '极客时间-算法', link: '/articles/reading-notes/geekbang-algorithm/' },
                    { text: '极客时间-重学前端', link: '/articles/reading-notes/geekbang-winter/' },
                    { text: '极客时间-网络', link: '/articles/network-study/' },
                ]
            },
            {
                text: '源码解析',
                items: [
                    { text: 'SDWebImage', link: '/articles/sd/' },
                    { text: 'Runtime', link: '/articles/runtime/index/' },
                ]
            },
            {
                text: '算法',
                items: [
                    { text: '哈希表', link: '/articles/hash-map/' },
                    { text: '查找', link: '/articles/search/' },
                    { text: '面试遇到的算法', link: '/articles/algorithm-interview/' },
                ]
            },
            {
                text: '网络',
                items: [
                    { text: '哈希表', link: '/articles/networking/' },
                    { text: 'HTTP与HTTPS', link: '/articles/http-https/' },
                ]
            },
            {
                text: '工程化',
                items: [
                    { text: 'iOS 代码规范', link: '/articles/ios-coding-style/' },
                    { text: 'iOS 代码审核', link: '/articles/ios-code-review/' },
                    { text: '多环境配置', link: '/articles/configura/' },
                    { text: '开发者账号相关', link: '/articles/ios-app-on-line/' },
                    { text: 'UML类图', link: '/articles/uml/' },
                ]
            },
        ],
        sidebar: 'auto',
        lastUpdated: 'Last Updated',
        repo: 'https://github.com/hnxczk/hnxczk.github.io.git',

    }
}