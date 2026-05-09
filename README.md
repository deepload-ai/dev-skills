# dev-skills

AI Coding Skills Collection - 用于 Claude Code、OpenCode、Trae、Codex、Gemini、Cursor、Windsurf 等 AI 编程工具的自定义技能集

## 技能列表

### 1. refactor2docs

**版本**: v2.0

**用途**: 将大型代码库转化为结构化文档集，支撑完整项目重构

**触发场景**: 代码分析、文档生成、重构指南、架构文档、模块设计

**核心能力**:
- 八层文档架构（PRD、架构设计、模块设计、测试用例、构建部署、重构指南、技能文档、代码图谱）
- 四阶段分析流程（探索→分析→文档生成→验证）
- Mermaid 可视化图表
- 变更影响分析

**Skill 文件**:
```
refactor2docs/
├── SKILL.md          # 技能主文档 (8模块结构)
├── config.json       # 技能配置
└── references/       # 参考文档
```

---

### 2. docs2prd

**版本**: v2.0

**用途**: 将技术文档/文章转化为 PRD

**触发场景**: 转PRD、生成PRD、需求规格说明书

**核心能力**:
- 四步执行流程（源获取→解析→抽取→生成）
- IEEE 830 标准结构化
- C4 架构建模
- 信息溯源标记

**Skill 文件**:
```
docs2prd/
├── SKILL.md          # 技能主文档
├── config.json       # 技能配置
└── references/       # 参考文档
```

---

## 安装

### 自动安装脚本

#### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/deepload-ai/dev-skills/main/install.sh | bash
```

或手动运行：
```bash
git clone https://github.com/deepload-ai/dev-skills.git
cd dev-skills
./install.sh
```

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/deepload-ai/dev-skills/main/install.ps1 | iex
```

---

## 项目结构

```
dev-skills/
├── README.md              # 本文件
├── LICENSE                # MIT
├── install.sh             # Linux/macOS 安装脚本
├── install.ps1           # Windows 安装脚本
├── refactor2docs/        # 代码转文档重构技能 v2.0
└── docs2prd/            # 文档转PRD技能 v2.0
```

---

## 安装脚本选项

| 选项 | 说明 |
|------|------|
| `--tool <name>` | 只安装到指定工具 |
| `--force` | 强制安装到默认位置 |
| `--help` | 显示帮助 |

**支持的工具**: claude, opencode, trae, codex, gemini, cursor, windsurf
