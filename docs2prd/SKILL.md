---
name: docs2prd
description: Use when converting a specified article, document, PDF, webpage, meeting note, design note, or pasted text into a clear product requirements document (PRD), software requirements specification, or requirements brief. Do not use for codebase analysis, ordinary summaries, translation, or bug-fix work without PRD deliverables.
---

# Docs2PRD — 文档提炼为需求 PRD

## Outcome
把用户指定的文档提炼成清晰、可追溯、可验收的 PRD。默认中文输出；原文术语、代码、API、产品名保持原文。目标是“需求资产”，不是普通摘要。

## Hard Rules
- **来源优先**：核心需求、背景、方案、约束、术语必须来自原文并带溯源标记；补充内容必须标注 `【原文未明确提及，按通用产品/软件工程规范补充】`。
- **不编造**：原文没有用户、指标、架构、接口、数据、安全或业务目标时，写“原文未提及”，不要伪造。
- **PRD 可验收**：需求必须编号，验收标准必须可验证；原文无量化指标时只能给“建议指标/待确认指标”，不能伪装为原文事实。
- **先抽取后生成**：先做文档解析和信息抽取，再写 PRD；PRD 只能使用抽取表和明确标注的补充项。
- **低副作用**：除非用户指定输出路径，不要强制写入 `~/wiki` 或外部目录；默认在当前任务目录生成或直接回复 PRD。

## When Not to Use
- 用户只要普通摘要、读后感、翻译、润色或问答。
- 用户要求分析代码库生成重构文档；那属于 `refactor2docs`。
- 用户只修 bug 或写实现方案，不需要 PRD 交付物。

## Workflow

### Step 0 — Source Acquisition
目标：获得完整、可引用的原文。

- 输入是本地文件：读取全文；PDF/DOCX 需按对应文件技能提取文本。
- 输入是 URL：抓取正文；若内容可能变化或需精确引用，必须重新获取来源。
- 输入是粘贴文本：直接作为原文。
- 微信/公众号文章若出现验证节点但 HTML 含 `id="js_content"`，可提取该区块正文。

产物：原文文本、标题、作者/平台/URL（如有）、获取日期、原文结构。

### Step 1 — Parse & Purify
目标：去噪并建立溯源方式。

识别文档类型并选择溯源格式：
- 论文/规范体：`【原文第X章/X.Y节】`
- Markdown/博客体：`【原文“标题”】`
- 访谈/案例体：`【原文“话题/段落”】`
- 无结构文本：`【原文段落N】` 或 `【原文行Lx-Ly】`

去除广告、导航、作者引导、平台水印、重复目录和无关评论。保留定义、图表说明、数据、限制条件和示例。

Checkpoint: `Step 1 完成: 文档类型 {类型}, 溯源格式 {格式}, 有效正文约 N 字`

### Step 2 — Structured Extraction
执行前按需读取 `references/domain-knowledge.md`。

按 8 维抽取：业务背景、需求、方案、架构、数据、接口、边界、术语。每条抽取项包含：`内容 | 原文证据 | 确定性 | PRD落点`。

必须特别检查：
- 原文显式定义的术语是否 100% 收录。
- 隐性需求：包含“必须/应该/支持/避免/限制/不适用”等约束表达。
- 技术选型论据是否有原文证据。
- NFR、验收标准和指标哪些来自原文，哪些是待确认建议。

Checkpoint: `Step 2 完成: 8维抽取 N 条, 术语 M 个, 待确认 Q 项`

### Step 3 — Requirements Modeling
执行前按需读取 `references/prd-structure.md`。

将抽取表建模为 PRD：
- FR 使用 `FR-001` 编号；NFR 使用 `NFR-001` 编号；风险使用 `RISK-001` 编号。
- 每条需求至少包含：描述、来源、优先级、验收标准、待确认项（如有）。
- 架构内容存在时使用 Mermaid C4/flowchart/sequenceDiagram；原文无架构时只能生成“建议架构草案”，并标注补充来源。

Checkpoint: `Step 3 完成: FR X 条, NFR Y 条, 风险 Z 条, 图表 G 个`

### Step 4 — PRD Generation & Verification
执行前按需读取：
- `references/prd-structure.md`：PRD 模板、文档头、文件命名。
- `references/check-lists.md`：自检清单和常见陷阱。

输出完整 PRD，并执行自检。若用户指定路径，写入该路径；否则可在当前目录生成 `{产品名}-{文档类型}-{YYYYMMDD}.prd.md`，或按用户要求直接在回复中给出。

Checkpoint: `Step 4 完成: PRD 已生成, 自检 X/Y 通过, 未确认项 Q 个`

## Zero-Result Policy
| 缺失内容 | 正确写法 | 禁止 |
|---|---|---|
| 无性能指标 | `原文未给出量化指标；建议指标待产品确认` | 编造 99%、3s 等数字 |
| 无目标用户 | `原文未明确目标用户，基于上下文推测为...` | 写成确定用户画像 |
| 无架构描述 | `原文未覆盖架构；以下为建议架构草案` | 声称原文提出 C4 架构 |
| 无接口/数据 | `原文未提及接口/数据要求` | 补一套虚假 API |
| 无术语定义 | `原文未明确定义该术语` | 自行给权威定义 |

## Completion Contract
最终报告包含：PRD 输出位置或正文、核心需求数量、溯源/补充比例、自检结果、待确认问题。不要复述全部执行过程。
