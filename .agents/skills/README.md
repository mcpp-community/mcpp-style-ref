# mcpp-style-ref Agent Skills

用于指导 Agent 在编写或审查 Modern/Module C++ 代码时遵循 mcpp-style-ref 规范的技能。

## 可用技能

| 技能 | 说明 |
|------|------|
| [mcpp-style-ref](mcpp-style-ref/SKILL.md) | 面向 mcpp 项目的 Modern/Module C++ (C++23) 命名、模块化与实践规则 |

## 使用方式

要在 Cursor 中使用，请将技能软链接或复制到项目的 `.cursor/skills/`：

```bash
mkdir -p .cursor/skills
ln -s ../../skills/mcpp-style-ref .cursor/skills/mcpp-style-ref
```

或安装为个人技能：

```bash
ln -s /path/to/mcpp-style-ref/skills/mcpp-style-ref ~/.cursor/skills/mcpp-style-ref
```
