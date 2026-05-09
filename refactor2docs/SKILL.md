---
name: refactor2docs
description: Use when documenting a legacy or large codebase for refactoring, reverse-engineering architecture, generating project docs from source, building dependency/impact maps, or preparing a code graph. Do not use for isolated bug fixes, local function explanations, or general refactoring advice without documentation deliverables.
---

# Refactor2Docs — 源码转重构文档

## Outcome
把旧代码项目转化为可支撑重构的、来源可追溯的结构化文档集。默认中文输出；代码、API 名称和命令保持原文。

## Hard Rules
- **证据优先**：架构、接口、业务逻辑、依赖关系、测试建议都必须引用源码路径；关键结论尽量精确到 `file:line`。
- **不编造**：没找到模块、调用方、依赖、入口、注释或测试时，写明“未发现/基于代码推测”，禁止补虚假业务背景。
- **八层目标**：默认生成八层文档。若代码混乱导致某层无法详写，也要生成该层的缺口说明和后续补全条件。
- **先分析后写作**：Phase 3 只能使用 Phase 1/2 的模块清单、依赖图、接口清单和风险清单作为输入；新增结论必须补证据。
- **自主推进**：不要在 checkpoint 后等待确认；除非用户要求分阶段交付，否则继续执行到验证闭环或明确阻塞。

## When Not to Use
- 只解释单个函数、单个文件，且不需要项目级文档。
- 只修一个 bug，且不要求更新架构/测试/影响分析文档。
- 纯概念性“如何重构”咨询。

## Workflow

### Phase 1 — Exploration
目标：识别项目规模、入口、模块边界、技术栈、配置和已有文档。

最小产物：
- 文件/语言/目录规模统计。
- 入口文件、核心配置、构建/测试命令候选。
- 模块清单：`模块名 | 路径 | 角色 | 关键文件 | 证据`。
- 风险标记：巨型文件、循环依赖、缺测试、过度耦合、废弃代码候选。

Checkpoint: `Phase 1 完成: 识别 N 个模块, M 个关键入口/配置, 主要风险 R 项`

### Phase 2 — Analysis
目标：对模块做可追溯分析，形成文档生成输入。

必须提取：
- 分层架构与跨层调用。
- 核心类/函数/接口/数据模型。
- 上游调用者、下游依赖、跨模块边界。
- 关键流程、异常路径、权限/安全/持久化/外部 IO。
- 现有测试与缺口；没有测试时基于代码行为设计目标测试。

Checkpoint: `Phase 2 完成: 分析 N/M 个模块, 依赖 X 条, 接口 Y 个, 风险 Z 项`

### Phase 3 — Documentation
执行前按需加载：
- `references/domain-knowledge.md`：完整八层目录、文档粒度和证据规则。
- `references/templates.md`：Markdown/Mermaid 模板。
- `references/delegation.md`：模块多时的子 Agent 并行协议。

Decision gate:
- **逻辑清晰**：按八层目录生成完整文档。
- **逻辑混乱/高度耦合**：仍保留八层结构；优先写 `06-重构指南/实施清单.md`、`06-重构指南/07-变更影响分析/*` 和相关缺口说明，详细设计标注“待解耦后补全”。

必须包含：
- PRD 从代码行为反推，但业务意图不足时标注“基于代码推测”。
- 架构/详细设计包含源码证据、接口定义、数据流、异常流和 Mermaid 图。
- 测试文档不复述现有 test；要基于重构目标重新梳理单元、集成、E2E 和边界条件。
- 代码图谱包含模块依赖、关键执行流、数据流、符号索引和机器可读 `meta.json`。

Checkpoint: `Phase 3 完成: 生成 X/8 层, Y 个文件, 已标注缺口 G 项`

### Phase 4 — Verification
执行前按需加载 `references/verification.md`。

验证：
- 八层目录存在或有明确缺口说明。
- 每个核心结论有源码路径；关键结论有行号。
- Mermaid 语法可解析或至少人工语法检查通过。
- 文档链接无断链，`meta.json` 是合法 JSON。
- 模块/接口/依赖数量与 Phase 1/2 产物一致；不一致必须解释。

Checkpoint: `Phase 4 完成: 验证 X/Y 通过, 断链 0, 未证实结论 0 或已列入缺口`

## Tooling Guidance
- 优先使用语义/代码搜索和文件读取工具；失败时可用 `find`、`grep`、`rg`、`cat` 降级，并标注 `⚠️ 降级: 原因`。
- 单次超时不代表工具不可用；缩小范围后重试。
- 大代码库先抽样定位架构，再按模块并行/分批深入。

## Zero-Result Policy
| 场景 | 输出 | 禁止 |
|---|---|---|
| 无模块发现 | `未在 {path} 发现模块边界` | 猜模块名 |
| 无调用方 | `未发现显式调用点` | 编造调用链 |
| 无业务注释 | `业务语义基于命名/流程推测` | 写成确定业务规则 |
| 无测试 | `未发现现有测试；以下为目标测试设计` | 声称已有覆盖 |
| 无模板字段依据 | `该字段缺少源码证据，列入待确认` | 复制相似项目内容 |

## Completion Contract
最终回复只报告：生成/更新的文档位置、核心发现、验证证据、缺口/风险和建议下一步。不要复述完整流程。
