# mcpp-style-ref

> Modern/Module C++ Style Reference | 现代C++编码/项目风格参考

[![C++23](https://img.shields.io/badge/C%2B%2B-23-blue.svg)](https://en.cppreference.com/w/cpp/23)
[![Module](https://img.shields.io/badge/module-ok-green.svg)](https://en.cppreference.com/w/cpp/language/modules)
[![License](https://img.shields.io/badge/license-Apache_2.0-blue.svg)](LICENSE-CODE)

| [示例代码](./src) - [官网](https://mcpp.d2learn.org) - [论坛](https://mcpp.d2learn.org/forum) - [Agent Skills](.agents/skills/README.md) |
| --- |

```cpp
import std;

int main() {
    std::println("开启你的现代C++模块化之旅...");
}
```

> [!CAUTION]
> 现代C++编码/项目风格文档, 仅作为模块化C++项目的参考且在不断完善中, 如有问题或想法欢迎[创建 issues](https://github.com/mcpp-community/mcpp-style-ref/issues)或[论坛发帖](https://mcpp.d2learn.org/forum)交流, 参与贡献请先阅读 [参与贡献](#参与贡献)

## 快速开始

### 使用项目的skills

> 一键安装 `mcpp-style-ref` skills到你的项目, 然后使用该skills即可快速配置C++23环境并编写模块的项目

```
xlings install skills:mcpp-style-ref
```

注: 获取xlings工具见 -> [xlings - 开源的通用包管理器项目](https://github.com/d2learn/xlings)

### 使用项目的`.clang-format`

> 直接复制[.clang-format](), 或使用xlings进行安装

```
xlings install mcpp:clang-format
```

## 目录

- 一、`标识符`命名风格
  - 1.0 [类型名 - 大驼峰](./README.md#10-类型名---大驼峰)
  - 1.1 [对象/数据成员 - 小驼峰](./README.md#11-对象数据成员---小驼峰)
  - 1.2 [函数 - 下划线(snake_case)](./README.md#12-函数---下划线snake_case)
  - 1.3 [私有表示 - `_`后缀](./README.md#13-私有表示---_后缀)
  - 1.4 [空格 - 增强可读性](./README.md#14-空格---增强可读性)
  - 1.5 [其他](./README.md#15-其他)
- 二、模块化
  - 2.0 [使用`import xxx`替代`#include <xxx>`](./README.md#20-使用import-xxx替代include-xxx)
  - 2.1 [模块文件结构](./README.md#21-模块文件结构)
  - 2.2 [使用模块`.cppm`替代头文件`.h`、`.hpp`](./README.md#22-使用模块cppm替代头文件hhpp)
  - 2.3 [模块实现与接口导出分离](./README.md#23-模块实现与接口导出分离)
  - 2.4 [模块及模块分区命名规范](./README.md#24-模块及模块分区命名规范)
  - 2.5 [多文件模块和目录](./README.md#25-多文件模块和目录)
  - 2.6 [可导出模块分区和内部模块分区](./README.md#26-可导出模块分区和内部模块分区)
  - 2.7 [模块化与向前兼容](./README.md#27-模块化与向前兼容)
  - 2.8 [其他](./README.md#28-其他)
    - 2.8.1 尽可能的少使用宏
    - 2.8.2 导出模板接口时注意全局静态成员
- 三、实践参考
  - 3.0 [auto 的使用](./README.md#30-auto-的使用)
  - 3.1 [统一使用 {} 初始化](./README.md#31-统一使用--初始化)
  - 3.2 [优先使用智能指针](./README.md#32-优先使用智能指针)
  - 3.3 [用 std::string_view 替代 char*](./README.md#33-用-stdstring_view-替代-char)
  - 3.4 [用 optional/expected 替代 int 错误码](./README.md#34-用-optionalexpected-替代-int-错误码)
  - 3.5 [RAII 资源管理](./README.md#35-raii-资源管理)

## 一、`标识符`命名风格

> 核心思想通过`标识符`风格设计, 能快速识别 - 类型、函数、数据以及封装性

下方示例综合展示各小节要点:

```cpp
import std;

namespace mcpplibs {  // 1.命名空间全小写
namespace mylib {

class StyleRef {     // 2.类型名大驼峰

private:
    int data_; // 3.私有数据成员 xxx_
    std::string fileName_; // std::string

public: // 4. 构造函数 / Rule of Five（Big Five）单独放一个 public 区域

    StyleRef() = default;
    StyleRef(const StyleRef&) = default;
    StyleRef(StyleRef&&) = default;
    StyleRef& operator=(const StyleRef&) = default;
    StyleRef& operator=(StyleRef&&) = default;
    ~StyleRef() = default;

public:  // 5.公有函数区域 — 函数名 snake_case, 参数名小驼峰

    // 函数名 下划线分割 / snake_case
    /* 7. fileName 小驼峰 */
    void load_config_file(std::string fileName) {
        // 成员函数如无特殊要求接口和实现不分离
        parse_(fileName);
    }

private:

    // 6.私有成员函数以 `_` 结尾
    void parse_(std::string config) {

    }

};

} // mylib
} // mcpplibs
```

### 1.0 类型名 - 大驼峰

> 单词首字母都大写, 单词之间不加下划线. 

- 例: `StyleRef, HttpServer, JsonParser`

```cpp
struct StyleRef {
    using FileNameType = std::string;
}; 
```

### 1.1 对象/数据成员 - 小驼峰

> 一个单词首字母小写, 后续单词首字母大写, 不加下划线

- 例: `fileName, configText`

```cpp
struct StyleRef {
    std::string fileName;
};

StyleRef mcppStyle;
```

### 1.2 函数 - 下划线(snake_case)

> 全小写(通常), 单词用下划线连接

- 例: `load_config_file(), parse_(), max_retry_count()`

```cpp
class StyleRef {
public:
    void load_config_file(const std::string& fileName) {

    }
};
```

### 1.3 私有表示 - `_`后缀

> 在标识符后加上`_`表示是对外部不可访问/私有的数据, 即可以是数据成员也可以是函数

- 例: `fileName_, parse_`

```cpp
class StyleRef {
private:
    std::string fileName_;

    void parse_(const std::string& config) {

    }
};
```

### 1.4 空格 - 增强可读性

> 在符号两侧使用空格, 提升可读性

- **推荐**: `T x { ... }` 符号两侧留空
- **例**: `int n { 42 }`, `std::vector<int> v { 1, 2, 3 }`

```cpp
int n { 42 };
struct Point { int x, y; };
Point p { 10, 20 };
```

### 1.5 其他

- **不可变常量** (替代宏): 全大写 + 下划线, 例: `MAX_SIZE`, `DEFAULT_TIMEOUT`
- **全局数据/成员**: 前缀 `g`, 例: `StyleRef gStyleRef;`
- **模版命名**: 可以参考 类和函数 的命名风格

## 二、模块化

### 2.0 使用`import xxx`替代`#include <xxx>`

**旧式`#include`写法**

```cpp
#include <print>;

int main() {
    std::println("Hello, MC++!");
}
```

**模块导入写法**

```cpp
import std;

int main() {
    std::println("Hello, MC++!");
}
```

### 2.1 模块文件结构

```cpp
// 0.全局模块片段(可选)
module; // 当需要使用传统头文件时使用

// 1.传统头文件引入区域
#include <xxx>

// 2.模块声明和导出
export module module_name;

// 2.1 导入导出模块分区接口 (可选)
//export module :xxxx;

// 3.模块导入区域
import std;
import xxx;

// 3.1 导入模块分区接口 (可选)
//import :xxxxx;

// 4.接口导出与实现区域
export int add(int a, int b) {
    return a + b;
}
```

### 2.2 使用模块`.cppm`替代头文件`.h`、`.hpp`

> 可以把导出接口和接口实现都放到`.cppm`文件中.

#### 2.2.1 传统代码文件风格

**传统风格1 - `.cpp` + `.h`**

```cpp
// mcpplibs.h
#ifndef MCPPLIBS_H
#define MCPPLIBS_H

int add(int a, int b);

#endif
```

```cpp
// mcpplibs.cpp
#include <mcpplibs.h>

int add(int a, int b) {
    return a + b;
}
```

**传统风格2 - `.hpp`**

```cpp
// mcpplibs.hpp
#ifndef MCPPLIBS_HPP
#define MCPPLIBS_HPP

int add(int a, int b) {
    return a + b;
}

#endif
```

#### 2.2.2 模块化文件

> 模块中的接口, 默认外界是不能使用的.要导出的接口需要在前面加`export`关键字

```cpp
// mcpplibs.cppm

// 模块导出
export module mcpplibs;

// 接口导出
export int add(int a, int b);

// 接口实现
int add(int a, int b) {
    return a + b;
}
```

或

```cpp
// mcpplibs.cppm

// 模块导出
export module mcpplibs;

// 接口导出 & 实现
export int add(int a, int b) {
    return a + b;
}
```

### 2.3 模块实现与接口导出分离

#### 2.3.1 方式一: 命名空间隔离

> 通过命名空间隔离模块实现和接口导出, 可以有选择的控制导出接口

```cpp
// mcpplibs.cppm

// 模块导出
export module mcpplibs;

// 模块的具体实现 / 私有接口
namespace mcpplibs_impl {
    int add(int a, int b) {
        return a + b;
    }

    int other(int a, int b) {
        return a + b;
    }
};

// 导出整个命名空间
// 然后把部分需要导出的接口放到这个导出空间中
export namespace mcpplibs {
    using mcpplibs_impl::add;
};
```

#### 2.3.2 方式二: 模块单元 + 实现单元 (.cppm + .cpp)

> 将接口放在 `.cppm` 模块单元, 实现放在 `module xxx;` 的实现单元 `.cpp` 中, 实现可在编译期隐藏

**`error.cppm`** — 模块接口

```cpp
export module error;

export struct Error {
    void test();
};
```

**`error.cpp`** — 模块实现

```cpp
module error;

import std;

void Error::test() {
    std::println("Hello");
}
```

### 2.4 模块及模块分区命名规范

> 使用文件(及目录)名 + `.`层级分割符进行模块命名, 降低同名模块冲突概率

- 模块名格式: `topdir.subdir1.subdir2.filename`
- 模块分区名: `topdir.subdir1.subdir2.module_filename:filename`

#### 项目结构

```cpp
.
├── a
│   └── c.cppm
├── b
│   └── c.cppm
└── main.cpp
```

#### 模块命名示例

`a/c.cppm`

```cpp
//...
export module a.c;
//...
```

`b/c.cppm`

```cpp
//...
export module b.c;
//...
```

#### `main.cpp`中使用

```cpp
import std;

import a.c;
import b.c;

int main() {
    //...
}
```

### 2.5 多文件模块和目录

> 当一个模块内容太多, 需要进一步分文件时可以采用 `目录` + `模块或模块分区组合`的方式进行实现

- 一个文件夹 + 一个模块声明文件
  - 文件夹: 同一模块的实现分散到不同文件实现
  - 模块文件: 对外接口导出的汇总文件

#### 2.5.1 项目结构

```cpp
.
├── a // 模块a实现
│   ├── a1.cppm // a:a1
│   ├── a2.cppm // a:a2
│   ├── b // 模块a.b实现
│   │   ├── b1.cppm // a.b:b1;
│   │   └── b2.cppm // a.b:b2;
│   ├── b.cppm // 模块a.b声明及导出
│   └── c.cppm // 独立模块a.c的实现 + 声明及导出(都在一个文件)
├── a.cppm       // 模块a声明及导出
├── error.cppm   // 模块 error 接口 (接口与实现分离示例)
├── error.cpp    // 模块 error 实现
└── main.cpp

3 directories, 9 files
```

#### 2.5.2 模块

**`a.b`模块**

> 模块的导出文件

```cpp
// a/b
export module a.b;

export import :b1; // 导出a.b的b1分区
export import :b2; // 导出a.b的b2分区

//...
```

**`a.b:b1`模块分区**

```cpp
// a/b/b1.cppm
export module a.b:b1;
//...
```

**`a.b:b2`模块分区**

```cpp
// a/b/b2.cppm
export module a.b:b2;
//...
```

**`a`模块**

```cpp
// a.cppm
export module a;

export import a.b;
export import :a2; // 导入&出模块a的分区a2

import std;
import :a1; // 导入模块a的内部分区a1

export namespace a {
    //...
}
```

### 2.6 可导出模块分区和内部模块分区

> 当一个模块有多个分区时，应区分可导出的分区以及仅供内部使用的分区

#### 2.6.1 分区实现

**`a.a2`可导出模块分区**

> 通过`export`修饰模块分区

```cpp
// a/a2.cppm
export module a:a2;
//...
```

**`a.a1`内部模块分区**

> 内部模块分区, 不能使用`export`来修饰模块名和分区里的接口

```cpp
// a/a1.cppm
module a:a1;
//...

// export void test() { } // error
void test() { } // ok
```

#### 2.6.2 使用分区

```cpp
export module a;

export import :a2; // 使用可导出分区要加export

import :a1; // 使用内部分区不能加export且只能模块内部使用
```

### 2.7 模块化与向前兼容

> C/C++已有生态中没有模块化的库, 可以把项目所有引入的传统头文件库封装到一个专门的"兼容模块中", 然后在该模块中把接口进行"重新导出", 来最小化 `全局模块/传统头文件` 的使用范围

`c语言lua库, 以lua.cppm的方式用模块化"重导入"`

```cpp
module;

#ifdef __cplusplus
extern "C" {
#endif

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#ifdef __cplusplus
}
#endif

export module lua;

//import std;

export namespace lua {
    using lua_State = ::lua_State;
    using lua_CFunction = ::lua_CFunction;

    //...
}
```

### 2.8 其他

#### 2.8.1 尽可能的少使用宏

> 宏在模块化 C++ 中应谨慎使用. 宏定义在预处理阶段展开, 与模块的编译模型不同, 可能带来难以预料的行为. 优先考虑 `constexpr`、`inline`、`concept` 等替代方案.

```cpp
// 避免: 使用宏定义常量
#define MAX_SIZE 1024

// 推荐: 使用 constexpr, 命名沿用宏风格全大写+下划线
export module mylib;
export constexpr int MAX_SIZE = 1024;
```

```cpp
// 避免: 使用宏做条件编译逻辑
#ifdef DEBUG
    do_something();
#endif

// 推荐: 使用 constexpr + if 或模块内实现选择; 全局常量加 g 前缀
export module mylib;
constexpr bool g_debug = /* ... */;
if constexpr (g_debug) {
    do_something();
}
```

#### 2.8.2 导出模板接口时注意全局静态成员

> 导出包含全局静态成员的模板时, 需注意 ODR (One Definition Rule) 及模块链接语义. 模板的全局静态成员在每个翻译单元中可能有独立副本, 若需单例语义, 应使用 `inline` 变量或显式实例化.

```cpp
export module mylib;

// 注意: 每个 import 该模块的翻译单元可能拥有独立的 instance 副本
export template<typename T>
struct Trait {
    static T instance;  // 若在多个 .cpp 中实例化, 需确保定义唯一
};

// 推荐: C++17 起使用 inline 确保单一定义
export template<typename T>
struct TraitInline {
    inline static T instance {};
};
```

## 三、实践参考

> 现代 C++ 常用编码实践, 提升代码健壮性、可读性与维护性

### 3.0 auto 的使用

> 在类型可推断或冗长时使用 `auto`, 在需要明确表达意图时保留显式类型

- **推荐**: 迭代器、lambda、复杂类型、类型明显可推断时使用 `auto`
- **避免**: 过度使用导致可读性下降; 需要明确类型表达意图时

类型明显可推

```cpp
// 具体参考: https://github.com/d2learn/d2x/blob/2a553452033316730e1542d54f54f99bd2b397f1/src/cmdprocessor.cppm#L66
auto app = cmdline::App("d2x")
    .version("0.1.3")
    //...
```

迭代器、lambda、复杂类型

```cpp
import std;

void process_items(std::vector<int>& vec) {
    for (auto& item : vec) {
        item *= 2;
    }

    auto result = [](int a, int b) { return a + b; }(1, 2);
    std::println("{}", result);
}
```

### 3.1 统一使用 {} 初始化

> 优先使用花括号 `{}` 进行统一初始化, 可避免窄化转换并支持聚合初始化

- **推荐**: 尽量使用 `T x { ... }` 或 `T x = { ... }`
- **避免**: 窄化转换; 与 `std::initializer_list` 歧义时需注意

```cpp
import std;

int main() {
    int n { 42 };
    std::vector<int> v { 1, 2, 3 };
    std::string s { "hello" };

    struct Point { int x, y; };
    Point p { 10, 20 };
}
```

### 3.2 优先使用智能指针

> 使用 `std::unique_ptr`、`std::shared_ptr` 管理动态内存, 避免裸 `new`/`delete`

- **推荐**: 明确所有权语义; 使用 `std::make_unique`、`std::make_shared`
- **避免**: 裸 `new`/`delete`; 混用智能指针与裸指针

```cpp
import std;

class Resource { /* ... */ };

void use_resource() {
    auto p = std::make_unique<Resource> {};
    // 无需手动 delete
}

void share_resource() {
    auto p = std::make_shared<Resource> {};
    // 引用计数管理生命周期
}
```

### 3.3 用 std::string_view 替代 char*

> 对只读字符串参数使用 `std::string_view`, 避免拷贝且可接受多种字符串类型

- **适用**: 函数参数、临时字符串、不拥有内存的只读视图
- **注意**: `string_view` 不拥有数据, 调用方需保证底层数据有效

```cpp
import std;

void process(std::string_view input) {
    for (auto c : input) {
        // 处理字符, 无需拷贝
    }
}

int main() {
    process("literal");                           // C 字符串
    process(std::string { "temp" });              // std::string
    process(std::string { "prefix" }.substr(0, 3)); // string 子串
}
```

### 3.4 用 optional/expected 替代 int 错误码

> 使用 `std::optional` 表示"可有可无", 使用 `std::expected` 表示"成功或错误", 替代传统的 int 错误码

- **std::optional** (C++17): 表示可能无值, 如解析失败、查找未命中
- **std::expected** (C++23): 表示成功返回值或错误信息, 类型安全地表达错误

```cpp
import std;

// optional: 表示"可能没有结果"
std::optional<int> parse_int(std::string_view s) {
    int value {};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    if (ec != std::errc {}) return std::nullopt;
    return value;
}

// expected: 表示"成功或错误" (C++23)
std::expected<int, std::string> try_parse(std::string_view s) {
    int value {};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    if (ec != std::errc {}) return std::unexpected { "parse failed" };
    return value;
}

void example() {
    if (auto v = parse_int("42")) {
        std::println("got {}", *v);
    }

    auto r = try_parse("abc");
    if (r) std::println("got {}", *r);
    else std::println("error: {}", r.error());
}
```

### 3.5 RAII 资源管理

> 将资源获取与对象生命周期绑定, 构造时获取、析构时释放, 避免泄漏与遗漏

- **适用**: 文件句柄、锁、自定义句柄等 (智能指针见 3.2)
- **推荐**: 优先使用标准库 RAII 类型, 如 `std::fstream`、`std::lock_guard`

```cpp
import std;

// 作用域与生命周期: 离开作用域时自动析构
void read_file(std::string_view path) {
    std::ifstream f { std::string { path } };  // 析构时自动关闭
    std::string line;
    while (std::getline(f, line)) { /* ... */ }
}

void with_lock() {
    std::mutex m;
    std::lock_guard lock { m };  // 析构时自动 unlock
    // 临界区
}

// 类的构造与析构: 封装资源
struct AutoLog {
    std::string_view name;
    explicit AutoLog(std::string_view n) : name { n } { std::println("{} 开始", name); }
    ~AutoLog() { std::println("{} 结束", name); }
};
```

---

## 相关链接

- [mcpp社区官网](https://mcpp.d2learn.org)
- [mcpp开源主页](https://github.com/mcpp-community)

## 参与贡献

### 反馈与交流

有问题或想法时, 欢迎通过以下方式交流:

- [创建 issues](https://github.com/mcpp-community/mcpp-style-ref/issues)
- [论坛发帖](https://mcpp.d2learn.org/forum)

### 提交 PR

参与项目贡献时, 建议先创建 issue 说明:

- 添加/修改参考内容的原因
- 为何适合加入本规范 (规范宜保持简洁)
- 示例或对比说明 (可选)

**示例**: 实现参考: 增加「RAII 资源管理」参考 → 在 issue 中说明适用场景、区分、简要示例。讨论后即可提交 [Pull Request](https://github.com/mcpp-community/mcpp-style-ref/pulls) 进行修复或补充。

## 许可证

- **代码**: [Apache License 2.0](LICENSE-CODE)
- **文档**: [CC BY-NC-SA 4.0](LICENSE-DOCS)
