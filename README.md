# dev-skills

AI Coding Skills Collection - 用于 Claude Code 和 OpenCode 的自定义技能集

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

## 安装方式

### 对于 Claude Code

```bash
# 克隆到本地 skills 目录
git clone https://github.com/your-username/dev-skills.git ~/.claude/skills/dev-skills

# 或者复制单个 skill
cp -r refactor2docs ~/.claude/skills/
cp -r docs2prd ~/.claude/skills/
```

### 对于 OpenCode

```bash
# 克隆到本地 skills 目录
git clone https://github.com/your-username/dev-skills.git ~/.agents/skills/dev-skills

# 或者复制单个 skill
cp -r refactor2docs ~/.agents/skills/
cp -r docs2prd ~/.agents/skills/
```

---

## 项目结构

```
dev-skills/
├── README.md              # 项目说明
├── LICENSE                # 许可证
├── refactor2docs/         # 代码转文档重构技能
│   ├── SKILL.md          # 技能主文档
│   └── config.json       # 技能配置
└── docs2prd/             # 文档转PRD技能
    ├── SKILL.md          # 技能主文档
    └── config.json       # 技能配置
```

---

## 许可证

MIT License
