# dev-skills

AI Coding Skills Collection - 用于 Claude Code、OpenCode、Trae、Codex、Gemini、Cursor、Windsurf 等 AI 编程工具的自定义技能集

## 技能列表

### 1. refactor2docs

**用途**: 将大型代码库转化为结构化文档集，支撑完整项目重构

**触发场景**:
- 分析代码并生成文档
- 重构文档化项目
- 创建架构文档
- 模块设计文档

**核心能力**:
- 八层文档架构（PRD、架构设计、模块设计、测试用例、构建部署、重构指南、技能文档、代码图谱）
- 四阶段分析流程（探索→分析→文档生成→验证）
- Mermaid 可视化图表
- 变更影响分析

**版本**: v2.0.0

---

### 2. docs2prd

**用途**: 将技术文章/文档转化为符合 IEEE 830 规范的产品需求规格说明书（PRD）

**触发场景**:
- 技术文章转 PRD
- 微信文章转需求文档
- 博客/论文转规格说明书

**核心能力**:
- 四步执行流程（解析预处理 → 8维抽取 → 结构化建模 → PRD生成）
- IEEE 830 标准结构化
- C4 架构建模（Context + Container）
- 信息溯源标记
- 量化验收标准

**版本**: v1.1.0

---

## 快速安装

### 方式一：一键安装脚本（推荐）

#### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/deepload-ai/dev-skills/main/install.sh | bash
```

或者先下载再运行：
```bash
git clone https://github.com/deepload-ai/dev-skills.git
cd dev-skills
./install.sh
```

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/deepload-ai/dev-skills/main/install.ps1 | iex
```

或者先下载再运行：
```powershell
git clone https://github.com/deepload-ai/dev-skills.git
cd dev-skills
.\install.ps1
```

安装脚本会自动检测已安装的 AI Coding 工具，并将技能安装到对应目录。

---

### 方式二：手动安装

#### Claude Code
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.claude/skills/dev-skills
```

#### OpenCode
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.agents/skills/dev-skills
```

#### Trae
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.trae/skills/dev-skills
```

#### Codex CLI
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.codex/skills/dev-skills
```

#### Gemini CLI
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.gemini/skills/dev-skills
```

#### Cursor
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.cursor/skills/dev-skills
```

#### Windsurf
```bash
git clone https://github.com/deepload-ai/dev-skills.git ~/.windsurf/skills/dev-skills
```

---

## 安装脚本选项

### 指定特定工具
```bash
# 只安装到 Claude Code
./install.sh --tool claude

# 只安装到 OpenCode
./install.sh --tool opencode
```

### 强制安装
如果自动检测失败，可以强制安装到默认位置：
```bash
./install.sh --force
```

### 查看帮助
```bash
./install.sh --help
```

---

## 项目结构

```
dev-skills/
├── README.md              # 项目说明
├── LICENSE                # 许可证
├── install.sh             # Linux/macOS 安装脚本
├── install.ps1            # Windows PowerShell 安装脚本
├── refactor2docs/         # 代码转文档重构技能
│   ├── SKILL.md          # 技能主文档
│   └── config.json       # 技能配置
└── docs2prd/             # 文档转PRD技能
    ├── SKILL.md          # 技能主文档
    └── config.json       # 技能配置
```

---

## 支持的 AI Coding 工具

| 工具 | 配置目录 | 状态 |
|------|----------|------|
| [Claude Code](https://claude.ai/code) | `~/.claude/skills/` | ✅ 支持 |
| [OpenCode](https://opencode.ai) | `~/.agents/skills/` | ✅ 支持 |
| [Trae](https://trae.ai) | `~/.trae/skills/` | ✅ 支持 |
| [Codex CLI](https://github.com/openai/codex) | `~/.codex/skills/` | ✅ 支持 |
| [Gemini CLI](https://ai.google.dev/gemini-api) | `~/.gemini/skills/` | ✅ 支持 |
| [Cursor](https://cursor.sh) | `~/.cursor/skills/` | ✅ 支持 |
| [Windsurf](https://windsurf.io) | `~/.windsurf/skills/` | ✅ 支持 |

---

## 使用方法

安装完成后，在 AI Coding 工具中直接引用技能名称即可触发：

### refactor2docs 使用示例
```
用户: "分析这个项目并生成重构文档"
→ 触发 refactor2docs 技能

用户: "帮我文档化这个代码库"
→ 触发 refactor2docs 技能

用户: "生成架构设计文档"
→ 触发 refactor2docs 技能
```

### docs2prd 使用示例
```
用户: "把这篇文章转成 PRD"
→ 触发 docs2prd 技能

用户: "生成需求规格说明书"
→ 触发 docs2prd 技能

用户: "将微信文章转化为产品需求文档"
→ 触发 docs2prd 技能
```

---

## 技能配置说明

每个技能包含以下文件：

### SKILL.md
技能主文档，包含：
- 技能概述和使用场景
- 详细的执行流程
- 最佳实践和示例
- 常见问题解答

### config.json
技能配置文件，包含：
```json
{
  "name": "技能名称",
  "version": "版本号",
  "description": "技能描述",
  "author": "作者",
  "scope": "作用范围 (user/project)",
  "language": "语言",
  "tags": ["标签列表"],
  "triggers": ["触发关键词"],
  "entry": "入口文件",
  "category": "分类",
  "priority": 优先级
}
```

---

## 贡献

欢迎提交 Issue 和 PR！

---

## 许可证

MIT License
