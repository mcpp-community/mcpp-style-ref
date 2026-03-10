# Clang-Format 配置

本文件描述一套本社区适用的 `clang-format` 配置规则与示例，旨在统一项目代码风格、提高可读性并减少格式化争议。以下配置项与示例基于常见的 C++23 项目实践。

# 1. 缩进规则（Indentation）

对应配置：

```yaml
IndentWidth: 4
TabWidth: 4
UseTab: Never
```

规则说明：

- 使用 **4 个空格缩进**
- **禁止使用 Tab**

## 格式化前

```cpp
int main(){
if(true){
std::cout<<"hello"<<std::endl;
}
}
```

## 格式化后

```cpp
int main() {
    if (true) {
        std::cout << "hello" << std::endl;
    }
}
```

------------------------------------------------------------------------

# 2. 行宽限制（Line Width）

对应配置：

```yaml
ColumnLimit: 100
```

规则说明：

- 每行最大 **100 字符**
- 超出时自动换行

## 格式化前

```cpp
auto result = some_object.with_a_very_long_name().do_something().do_something_else().final_result();
```

## 格式化后

```cpp
auto result = some_object.with_a_very_long_name()
                   .do_something()
                   .do_something_else()
                   .final_result();
```

------------------------------------------------------------------------

# 3. 空格规则（Spaces）


对应配置：

```yaml
SpaceBeforeParens: ControlStatements
SpacesInContainerLiterals: true
SpaceBeforeAssignmentOperators: true
PointerAlignment: Left
QualifierAlignment: Left
```

规则说明：

- 函数调用与括号贴紧（`foo(1)`）；控制语句（`if/for/while`）与括号之间保留空格（`if (cond)`）。
- 容器字面量 **强制空格**
- 赋值运算符两侧必须有空格
- 指针/引用贴近类型
- `const` 等限定符位于类型左侧

## 格式化前

```cpp
int* a=&x;
std::vector<int>{1,2,3};
foo (1,2);
int const *p;
```

## 格式化后

```cpp
int* a = &x;
std::vector<int>{ 1, 2, 3 };
foo(1, 2);
const int* p;
```

------------------------------------------------------------------------

# 4. 大括号规则（Braces）

对应配置：

```yaml
BreakBeforeBraces: Attach
AllowShortFunctionsOnASingleLine: Empty
AllowShortIfStatementsOnASingleLine: Never
AllowShortBlocksOnASingleLine: Empty
```

规则说明：

- 左大括号 **不换行**
- 空函数允许单行
- `if/else` 不允许单行语句

## 格式化前

```cpp
void f()
{
}

if(x) foo();
```

## 格式化后

```cpp
void f() {}

if (x) {
    foo();
}
```

------------------------------------------------------------------------

# 5. 构造函数初始化列表（Constructor Initializer List）

对应配置：

```yaml
BreakConstructorInitializers: BeforeColon
ConstructorInitializerAllOnOneLineOrOnePerLine: true
```

规则说明：

- 初始化列表默认保持 **单行**
- 过长时自动换行

## 格式化前

```cpp
A::A():a(1),b(2){}
```

## 格式化后

```cpp
A::A() : a(1), b(2) {}
```

------------------------------------------------------------------------

# 6. 访问控制符（Access Modifier）

对应配置：

```yaml
AccessModifierOffset: -4
EmptyLineBeforeAccessModifier: Never
EmptyLineAfterAccessModifier: Never
```

规则说明：

- `public/private/protected` 与类体 **对齐**
- 不自动插入空行

## 格式化前

```cpp
class A{
public:
int x;
private:
int y;
};
```

## 格式化后

```cpp
class A {
public:
    int x;
private:
    int y;
};
```

------------------------------------------------------------------------

# 7. 命名空间（Namespace）

对应配置：

```yaml
NamespaceIndentation: None
FixNamespaceComments: true
CompactNamespaces: true
```

规则说明：

- namespace 内部不增加额外缩进
- 自动补充 namespace 结束注释
- 支持 `namespace a::b` 写法

## 格式化前

```cpp
namespace a{
namespace b{

class Foo{};

}
}
```

## 格式化后

```cpp
namespace a::b {

class Foo {};

} // namespace a::b
```

------------------------------------------------------------------------

# 8. Switch / Case

对应配置：

```yaml
IndentCaseLabels: true
IndentCaseBlocks: true
```

规则说明：

- `case` 标签缩进
- case 内代码继续缩进

## 格式化前

```cpp
switch(x){
case 1:
foo();
break;
}
```

## 格式化后

```cpp
switch (x) {
    case 1:
        foo();
        break;
}
```

------------------------------------------------------------------------

# 9. Include 排序

对应配置：

```yaml
SortIncludes: true
IncludeBlocks: Regroup
```

规则说明：

- 标准库 `<...>` 优先
- 项目 `"..."` 其次

## 格式化前

```cpp
#include "b.h"
#include <vector>
#include "a.h"
#include <iostream>
```

## 格式化后

```cpp
#include <iostream>
#include <vector>

#include "a.h"
#include "b.h"
```

------------------------------------------------------------------------

# 10. 注释对齐

对应配置：

```yaml
AlignTrailingComments: true
SpacesBeforeTrailingComments: 2
```

规则说明：

- 行尾注释自动对齐
- 注释前保留两个空格

## 格式化前

```cpp
int a = 1; // comment
int abc = 2; // comment
```

## 格式化后

```cpp
int a   = 1;  // comment
int abc = 2;  // comment
```

------------------------------------------------------------------------

# 11. Template 排版

对应配置：

```yaml
AlwaysBreakTemplateDeclarations: Yes
```

规则说明：

- template 声明始终换行

## 格式化前

```cpp
template <typename T> class Foo{};
```

## 格式化后

```cpp
template <typename T>
class Foo {};
```

------------------------------------------------------------------------

# 12. Using 排序

对应配置：

```yaml
SortUsingDeclarations: true
```

## 格式化前

```cpp
using std::vector;
using std::string;
```

## 格式化后

```cpp
using std::string;
using std::vector;
```

------------------------------------------------------------------------

# 13. 返回类型（Return Type）

对应配置：

```yaml
AlwaysBreakAfterReturnType: None
```

规则说明：

- 默认不换行
- 超过 ColumnLimit 自动换行

## 格式化前

```cpp
template <typename T>
very::very::very::long::namespace::type<T> foo();
```

## 格式化后

```cpp
template <typename T>
very::very::very::long::namespace::type<T>
foo();
```

------------------------------------------------------------------------

# 14. requires 子句

对应配置：

```yaml
RequiresClausePosition: OwnLine
IndentRequiresClause: false
```

## 格式化前

```cpp
template<typename T> requires Foo<T> void bar();
```

## 格式化后

```cpp
template <typename T>
requires Foo<T>
void bar();
```

------------------------------------------------------------------------

## 其他配置

下面列出一些常见的 `clang-format` 配置项以供参考（这些项也出现在仓库的 `.clang-format` 中）：

- `SpacesInParentheses: false` — 括号内不额外加空格。
- `AllowShortLoopsOnASingleLine: false` — 禁止单行循环。
- `BreakConstructorInitializersBeforeComma: false` — 初始化列表不在逗号前换行。
- `BinPackParameters: true` / `BinPackArguments: true` — 允许函数参数/实参在一行内紧凑排列（有长度限制）。
- `BreakBeforeBinaryOperators: None` — 二元操作符换行时放在行尾（在需要时换行）。
- `PenaltyBreakBeforeFirstCallParameter: 10000` — 降低首次调用参数换行的优先性以避免链式调用被过早换行。
- `AllowShortLambdasOnASingleLine: All` — 允许短 lambda 写成单行。

文档以示例与解释为主，以上配置列出以便参考和快速查阅。
