# Clang-Tidy 配置

本文件描述一套本社区适用的 `clang-tidy` ，基于白名单（whitelist）策略，聚焦高价值的检查以提升代码质量、正确性、性能与可移植性，同时减少误报与过于风格化的规则。

适用场景：

- 现代 C++ 项目（C++20 / C++23）
- 通用基础库与泛型库
- 容器 / 算法 / 工具类库

------------------------------------------------------------------------

# 启用的检查类别

## 1. 编译器诊断

启用：

```
clang-diagnostic-*
```

作用：

- 将编译器警告统一纳入 `clang-tidy` 输出，便于 CI 与静态检查工具统一处理

------------------------------------------------------------------------

## 2. Clang 静态分析器

启用：

```
clang-analyzer-*
```

提供更深入的静态分析能力，例如：

- 空指针访问
- 未初始化变量
- 内存使用问题
- 逻辑错误

------------------------------------------------------------------------

## 3. Bug 检测

启用：

```
bugprone-*
```

用于发现常见编程错误，例如：

- use-after-move
- 可疑逻辑表达式
- sizeof 使用错误
- copy‑paste bug

------------------------------------------------------------------------

## 4. 性能优化建议

启用：

```
performance-*
```

检测潜在性能问题，例如：

- 不必要的对象拷贝
- range‑for 复制
- 低效容器操作

------------------------------------------------------------------------

## 5. 现代 C++ 改进

启用：

```
modernize-*
```

用于建议使用现代 C++ 特性，例如：

- `nullptr`
- `override`
- `using`
- `= default` / `= delete`
- `emplace`

为避免过于激进的修改，建议禁用部分可能带来大规模自动重写的规则（例如 `modernize-use-auto` 或 `modernize-avoid-c-arrays`），根据项目风险决策是否启用。

------------------------------------------------------------------------

## 6. 通用检查

启用：

```
misc-*
```

提供一些通用且误报较少的检查，例如：

- 未使用参数
- header 中定义问题
- 异常使用方式

------------------------------------------------------------------------

## 7. 可移植性检查

启用：

```
portability-*
```

用于检测潜在的跨平台问题，提高代码在不同编译器和平台上的兼容性。

------------------------------------------------------------------------

## 8. 部分可读性检查

启用规则：

```
readability-braces-around-statements
readability-implicit-bool-conversion
readability-simplify-boolean-expr
readability-qualified-auto
```

主要用于：

- 强制控制语句使用大括号
- 避免隐式 bool 转换
- 简化布尔表达式
- 提升 `auto` 声明可读性

------------------------------------------------------------------------

# 未启用的规则与理由

一些规则因风格主观性、与模板库/算法实现冲突或误报较多而不在默认白名单中。例如：

```
readability-identifier-naming
readability-magic-numbers
readability-function-size
```

此外，针对生态特定的规则集（如 `fuchsia-*`, `zircon-*`, `abseil-*`, `android-*`, `llvm-*`）通常不适用于通用 C++ 项目，因此不作为默认启用项。

------------------------------------------------------------------------

# 使用建议与示例

以下示例展示 `clang-tidy` 检查能提供的改进方向。

## 示例：缺少大括号

修改前：

```cpp
if (x > 0)
    doSomething();
```

建议检查：

```
readability-braces-around-statements
```

修改后：

```cpp
if (x > 0) {
    doSomething();
}
```

## 示例：不必要的拷贝

修改前：

```cpp
for (auto value : container) {
    process(value);
}
```

建议检查：

```
performance-for-range-copy
```

修改后：

```cpp
for (const auto& value : container) {
    process(value);
}
```

## 示例：use-after-move

修改前：

```cpp
std::string s = "hello";
auto t = std::move(s);

std::cout << s;
```

建议检查：

```
bugprone-use-after-move
```

修改后：

```cpp
std::string s = "hello";
auto t = std::move(s);

std::cout << t;
```

## 示例：现代化改进

修改前：

```cpp
int* p = NULL;
```

建议检查：

```
modernize-use-nullptr
```

修改后：

```cpp
int* p = nullptr;
```

------------------------------------------------------------------------

## 其他配置

下面补充一些常见的全局设置与 `CheckOptions` 示例，供参考：

- 白名单模式：通常以 `-*` 先禁用所有检查，然后显式启用需要的规则/类别（例如 `clang-diagnostic-*`, `clang-analyzer-*`, `bugprone-*`, `performance-*`, `modernize-*`, `misc-*`, `portability-*`），并可单独开启若干 `readability-*` 规则。
- 常见的全局设置：
    - `WarningsAsErrors: ''`（默认不将警告视为错误）
    - `HeaderFilterRegex: '.*'`（分析所有头文件）
    - `AnalyzeTemporaryDtors: false`
    - `FormatStyle: none`
- 示例 `CheckOptions`：
    - `readability-braces-around-statements.ShortStatementLines: 0`（强制在短语句处也使用大括号）
    - `modernize-loop-convert.MinConfidence: reasonable`（限制循环重写的信心阈值）
    - `performance-unnecessary-value-param.AllowedTypes: ''`（不额外放行类型作为按值参数）
    - `misc-unused-parameters.IgnoreVirtual: true`（忽略虚函数重载中的未使用参数警告）

如需在项目中使用这些设置，可参考仓库根目录的 `.clang-tidy` 文件并按需调整以纳入 CI。
