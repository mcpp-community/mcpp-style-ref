# mcpp-style-ref

> Modern/Module C++ Style Reference | 现代C++编码/项目风格参考

[![C++23](https://img.shields.io/badge/C%2B%2B-23-blue.svg)](https://en.cppreference.com/w/cpp/23)
[![Module](https://img.shields.io/badge/module-ok-green.svg)](https://en.cppreference.com/w/cpp/language/modules)
[![License](https://img.shields.io/badge/license-Apache_2.0-blue.svg)](LICENSE-CODE)

| [示例代码](./src) - [官网](https://mcpp.d2learn.org) - [论坛](https://mcpp.d2learn.org/forum) |
| --- |

```cpp
import std;

int main() {
    std::println("开启你的现代C++模块化之旅...");
}
```

> [!CAUTION]
> 现代C++编码/项目风格文档, 仅作为模块化C++项目的参考且在不断完善中, 如果您有发现任何问题欢迎[创建issues](https://github.com/mcpp-community/mcpp-style-ref/issues)或[论坛发帖](https://mcpp.d2learn.org/forum)进行反馈, 或提交PR进行修复

## 目录

- 一、`标识符`命名风格
  - 1.0 [类型名 - 大驼峰](./README.md#10-类型名---大驼峰)
  - 1.1 [对象/数据成员 - 小驼峰](./README.md#11-对象数据成员---小驼峰)
  - 1.2 [函数 - 下划线(snake_case)](./README.md#12-函数---下划线snake_case)
  - 1.3 [私有表示 - `_`后缀](./README.md#13-私有表示---_后缀)
  - 1.4 [其他](./README.md#14-其他)
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

## 一、`标识符`命名风格

> 核心思想通过`标识符`风格设计, 能快速识别 - 类型、函数、数据以及封装性

下方示例综合展示各小节要点:

```cpp
import std;

namespace mcpplibs {  // 1.命名空间全小写

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

}
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

### 1.4 其他

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
    inline static T instance{};
};
```

---

## 相关链接

- [mcpp社区官网](https://mcpp.d2learn.org)
- [mcpp开源主页](https://github.com/mcpp-community)

## 参与贡献

发现问题或希望改进文档时, 欢迎通过以下方式反馈:

- [创建 issues](https://github.com/mcpp-community/mcpp-style-ref/issues)
- [论坛发帖](https://mcpp.d2learn.org/forum)
- 提交 [Pull Request](https://github.com/mcpp-community/mcpp-style-ref/pulls) 进行修复或补充

## 许可证

- **代码**: [Apache License 2.0](LICENSE-CODE)
- **文档**: [CC BY-NC-SA 4.0](LICENSE-DOCS)
