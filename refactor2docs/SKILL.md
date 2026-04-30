# Refactor2Docs - 代码转文档重构技能

**版本**: v1.0  
**作者**: Claude Code Agent  
**适用范围**: 大型代码库分析转文档，支撑完整项目重构

---

## 1. 技能概述

### 1.1 为什么需要这个技能

**问题**: 为什么源项目一开始没法转化成最终要求的文档？

**核心痛点**:
1. **代码规模大** - 1900+文件，51万+行代码，无从下手
2. **架构复杂** - 35+模块，多层架构，依赖关系复杂
3. **文档缺失** - 原始项目文档不完整，需要反向工程
4. **知识分散** - 关键逻辑分散在多个文件中
5. **重构困难** - 没有完整文档支撑，重构风险高

**解决方案**: 系统化的代码分析转文档方法论

### 1.2 技能目标

将大型代码库（1000+文件）转化为结构化、可重构的文档集，实现：
- ✅ 完整的架构理解
- ✅ 详细的模块设计
- ✅ 清晰的依赖关系
- ✅ 可执行的测试用例
- ✅ 可落地的重构指南

---

## 2. 核心方法论

### 2.1 七层文档架构（完整重构版）

```
01-需求文档/                    # 产品需求文档 (PRD)
  ├── 产品需求总览.md            # 整体产品需求
  ├── [模块]-PRD.md              # 各模块需求
  └── 用户故事.md                # 用户场景和故事

02-架构设计/                    # 系统架构设计
  ├── 系统架构总览.md            # 整体架构
  ├── [模块]架构设计.md           # 各模块架构
  ├── 数据流架构设计.md          # 数据流设计
  └── 安全架构设计.md            # 安全设计

03-模块设计/                    # 详细模块设计
  ├── [模块]-详细设计.md          # 各模块详细设计
  ├── 数据模型设计.md            # 核心数据模型
  └── API接口设计.md             # 接口规范

04-测试用例/                    # 测试规范（增强版）
  ├── 单元测试用例.md            # 单元测试规范
  ├── 集成测试用例.md            # 集成测试规范
  ├── E2E测试用例.md             # 端到端测试规范
  ├── 测试夹具.md                # 测试数据和夹具
  ├── 测试工具.md                # 测试工具和方法
  └── __tests__/                 # 实际测试文件（新增）
      ├── [模块]/
      │   └── [功能].test.ts     # 可运行的测试代码
      └── setup.ts               # 测试配置

05-构建部署/                    # 构建和部署（增强版）
  ├── 构建指南.md                # 构建说明
  ├── 部署指南.md                # 部署说明
  ├── 环境配置.md                # 环境配置
  ├── package.json               # 项目配置（新增）
  ├── tsconfig.json              # TypeScript配置（新增）
  ├── 依赖清单.md                # 完整依赖和版本（新增）
  └── Dockerfile                 # 容器配置（新增）

06-重构指南/                    # 重构指南（增强版）
  ├── 重构指南.md                # 重构策略和流程
  ├── 迁移指南.md                # 迁移说明
  ├── 实施清单.md                # 详细检查清单
  ├── 代码模板.md                # 可复用代码模板
  ├── 设计模式.md                # 设计模式库
  ├── 边界情况处理.md            # 边界和异常处理（新增）
  └── 性能优化指南.md            # 性能优化策略（新增）

07-技能文档/                    # 方法论记录
  ├── 代码分析转文档方法论.md    # 方法论记录
  └── 重构最佳实践.md            # 实践经验（新增）
```

### 2.2 完整重构检查清单

#### 🔴 Critical - 必须包含（无此无法重构）

- [ ] **项目配置**
  - [ ] package.json（完整依赖列表和版本）
  - [ ] tsconfig.json（TypeScript 配置）
  - [ ] 构建配置（vite.config.ts / webpack.config.js 等）
  - [ ] .env.example（环境变量模板）
  - [ ] bunfig.toml / package-lock.json（包管理器配置）
   
- [ ] **入口文件**
  - [ ] 主入口（main.ts / index.ts）
  - [ ] CLI 入口（cli.ts）
  - [ ] 模块入口（各模块 index.ts）
  - [ ] 启动脚本（bin/ 目录下的可执行脚本）
  - [ ] 本地恢复模式（localRecoveryCli.ts 等降级方案）

- [ ] **测试文件（可运行）**
  - [ ] 单元测试：`src/**/__tests__/*.test.ts`（至少覆盖核心模块）
  - [ ] 集成测试：`src/**/__tests__/*.integration.test.ts`
  - [ ] E2E 测试：`e2e/*.test.ts`
  - [ ] 测试配置：`jest.config.js` / `vitest.config.ts`
  - [ ] 测试覆盖率报告（目标 >80%）
  - [ ] **测试文件必须是可运行的真实测试代码，不是规范文档！**

- [ ] **存根/替代文件**
  - [ ] stubs/ 目录（替代私有依赖的存根实现）
  - [ ] 每个存根文件必须包含完整的类型定义和模拟实现

- [ ] **核心类型定义**
  - [ ] 所有接口和类型定义
  - [ ] 品牌类型（Branded Types）
  - [ ] 联合类型和区分联合

#### 🟡 High - 重要（影响重构质量）

- [ ] **依赖版本清单**
  - [ ] 所有运行时依赖版本
  - [ ] 所有开发依赖版本
  - [ ] 对等依赖（peerDependencies）
  
- [ ] **核心算法实现**
  - [ ] 状态机定义和转换
  - [ ] 复杂业务逻辑
  - [ ] 数据处理算法

- [ ] **启动和运行配置**
  - [ ] bin/ 目录下的启动脚本
  - [ ] .env.example 环境变量模板
  - [ ] 本地开发运行指南
  - [ ] 降级模式（Recovery CLI）配置

#### 🟢 Medium - 建议包含（提高重构成功率）

- [ ] **边界情况处理**
  - [ ] 错误处理策略
  - [ ] 异常场景处理
  - [ ] 重试和降级逻辑
  
- [ ] **性能优化细节**
  - [ ] 缓存策略
  - [ ] 懒加载实现
  - [ ] 并发控制
  
- [ ] **调试和日志**
  - [ ] 日志级别定义
  - [ ] 调试工具使用
  - [ ] 监控埋点

### 2.3 四阶段分析流程

#### Phase 1: 探索阶段 (Exploration)

**目标**: 全面理解代码库结构和关键模块

**步骤**:
1. **整体结构探索**
   ```bash
   # 统计文件数量和代码行数
   find src -name "*.ts" -o -name "*.tsx" | wc -l
   find src -name "*.ts" -o -name "*.tsx" | xargs wc -l | tail -1
   
   # 查看目录结构
   ls -la src/
   tree -L 2 src/
   ```

2. **模块识别**
   - 识别核心模块（state, tools, components等）
   - 识别功能模块（buddy, bridge, voice等）
   - 识别服务模块（api, mcp, oauth等）

3. **关键文件定位**
   - 入口文件（main.tsx, cli.tsx）
   - 核心类/接口（Tool.ts, QueryEngine.ts）
   - 配置文件（package.json, tsconfig.json）

**输出**: 模块清单、文件清单、依赖关系图

#### Phase 2: 分析阶段 (Analysis)

**目标**: 深入理解每个模块的实现逻辑

**步骤**:
1. **架构分析**
   - 分层架构识别
   - 数据流分析
   - 依赖关系梳理

2. **模块分析**
   - 核心类/接口分析
   - 关键算法分析
   - 设计模式识别

3. **安全分析**
   - 权限机制
   - 数据流安全
   - 潜在风险点

**输出**: 架构图、类图、流程图、风险清单

#### Phase 3: 文档生成阶段 (Documentation)

**目标**: 生成完整的文档集

**文档生成顺序**:
1. **PRD文档** - 从代码提取功能需求
2. **架构设计** - 从整体到局部
3. **详细设计** - 深入到代码级别
4. **测试用例** - 覆盖核心功能
5. **重构指南** - 可落地的实施指南

**生成原则**:
- 中文优先
- 代码示例完整
- 架构图清晰
- 可追溯性（代码↔文档）

#### Phase 4: 验证阶段 (Verification)

**目标**: 确保文档完整性和可重构性

**完整重构检查清单 v2.0**:

```markdown
### 🔴 Critical - 必须验证

- [ ] **项目配置完整**
  - [ ] package.json 包含所有依赖和版本
  - [ ] tsconfig.json 配置完整
  - [ ] 构建配置文件存在
  
- [ ] **入口文件完整**
  - [ ] 所有入口文件有详细设计
  - [ ] 入口文件依赖关系清晰
  
- [ ] **核心类型完整**
  - [ ] 所有接口定义完整
  - [ ] 类型关系清晰
  - [ ] 品牌类型定义完整

### 🟡 High - 重要验证

- [ ] **测试代码可运行**
  - [ ] 单元测试文件可运行
  - [ ] 集成测试文件可运行
  - [ ] 测试覆盖核心功能
  
- [ ] **依赖版本明确**
  - [ ] 所有依赖版本号明确
  - [ ] 依赖关系清晰
  - [ ] 版本兼容性说明
  
- [ ] **核心算法详细**
  - [ ] 状态机定义完整
  - [ ] 算法步骤详细
  - [ ] 复杂逻辑有流程图

### 🟢 Medium - 建议验证

- [ ] **边界情况覆盖**
  - [ ] 错误处理策略完整
  - [ ] 异常场景有说明
  - [ ] 重试降级逻辑清晰
  
- [ ] **性能优化文档化**
  - [ ] 缓存策略说明
  - [ ] 性能优化点记录
  - [ ] 性能测试基准
  
- [ ] **调试工具完整**
  - [ ] 日志级别定义
  - [ ] 调试工具说明
  - [ ] 监控埋点文档
```

**验证方法**:
1. **文档审查**: 人工审查文档完整性
2. **代码对比**: 抽样对比文档和源码
3. **重构试验**: 尝试重构小部分验证可行性
4. **测试运行**: 运行测试验证功能正确性

---

## 3. 完整重构关键技术点

### 3.1 配置文件提取

**必须提取的配置文件**:

```bash
# 1. package.json - 项目依赖
# 包含：dependencies, devDependencies, scripts, engines

# 2. tsconfig.json - TypeScript 配置
# 包含：compilerOptions, include, exclude

# 3. 构建配置
# vite.config.ts / webpack.config.js / rollup.config.js

# 4. 测试配置
# jest.config.js / vitest.config.ts

# 5. 代码规范配置
# .eslintrc.js / .prettierrc

# 6. 环境配置
# .env.example / .env.development / .env.production
```

**提取方法**:
```bash
# 复制配置文件
cp analysis/project/package.json output/05-构建部署/
cp analysis/project/tsconfig.json output/05-构建部署/
cp analysis/project/vite.config.ts output/05-构建部署/

# 生成依赖清单
(cd analysis/project && npm list --json) > output/05-构建部署/依赖清单.json
```

### 3.2 测试文件生成

**测试文件应该包含**:

```typescript
// __tests__/state/store.test.ts
import { describe, test, expect, beforeEach } from 'vitest';
import { createStore } from '../../src/state/store';

describe('createStore', () => {
  let store: ReturnType<typeof createStore<{ count: number }>>;
  
  beforeEach(() => {
    store = createStore({ count: 0 });
  });
  
  test('should initialize with initial state', () => {
    expect(store.getState()).toEqual({ count: 0 });
  });
  
  test('should update state immutably', () => {
    const prevState = store.getState();
    store.setState(s => ({ count: s.count + 1 }));
    const newState = store.getState();
    
    expect(newState).toEqual({ count: 1 });
    expect(newState).not.toBe(prevState);
  });
  
  test('should not notify if state unchanged', () => {
    const listener = vi.fn();
    store.subscribe(listener);
    store.setState(s => s); // no change
    
    expect(listener).not.toHaveBeenCalled();
  });
  
  test('should notify subscribers on change', () => {
    const listener = vi.fn();
    store.subscribe(listener);
    store.setState(s => ({ count: 1 }));
    
    expect(listener).toHaveBeenCalledTimes(1);
  });
  
  test('should unsubscribe correctly', () => {
    const listener = vi.fn();
    const unsubscribe = store.subscribe(listener);
    unsubscribe();
    store.setState(s => ({ count: 1 }));
    
    expect(listener).not.toHaveBeenCalled();
  });
});
```

### 3.3 核心算法详细化

**算法文档应该包含**:

```markdown
# QueryEngine 消息循环详细设计

## 1. 状态机定义

```typescript
type QueryEngineState =
  | { type: 'idle' }
  | { type: 'processing'; message: Message; startTime: number }
  | { type: 'waiting_for_tool'; toolUse: ToolUse; timeout: number }
  | { type: 'error'; error: Error; retryCount: number }
  | { type: 'completed'; result: Result; duration: number };
```

## 2. 状态转换表

| 当前状态 | 事件 | 下一状态 | 动作 |
|---------|------|---------|------|
| idle | 收到用户输入 | processing | 初始化处理 |
| processing | AI 请求工具 | waiting_for_tool | 执行工具 |
| waiting_for_tool | 工具完成 | processing | 继续处理 |
| processing | AI 响应完成 | completed | 返回结果 |
| processing | 发生错误 | error | 错误处理 |
| error | 可重试 | processing | 重试 |
| error | 不可重试 | idle | 返回错误 |
| completed | 清理完成 | idle | 重置状态 |

## 3. 错误处理策略

### 3.1 网络错误
- 自动重试 3 次
- 指数退避: 1s, 2s, 4s
- 超过 3 次转为人工处理

### 3.2 工具错误
- 向 AI 报告错误详情
- AI 决定重试或替代方案
- 记录错误日志

### 3.3 超时处理
- 设置超时定时器
- 超时后取消操作
- 提示用户状态

## 4. 代码实现

```typescript
// 完整的状态机实现
class QueryEngine {
  private state: QueryEngineState = { type: 'idle' };
  private retryCount = 0;
  private maxRetries = 3;
  
  async process(message: Message): Promise<Result> {
    try {
      this.transition('processing', { message });
      
      while (this.state.type === 'processing') {
        const response = await this.callLLM(message);
        
        if (response.toolUse) {
          this.transition('waiting_for_tool', { toolUse: response.toolUse });
          const toolResult = await this.executeTool(response.toolUse);
          this.transition('processing', { toolResult });
        } else {
          this.transition('completed', { result: response });
          return response;
        }
      }
    } catch (error) {
      await this.handleError(error);
    }
  }
  
  private async handleError(error: Error): Promise<void> {
    if (this.retryCount < this.maxRetries && this.isRetryable(error)) {
      this.retryCount++;
      await this.delay(2 ** this.retryCount * 1000);
      this.transition('processing', { retry: true });
    } else {
      this.transition('error', { error });
      throw error;
    }
  }
}
```
```

### 3.4 边界情况文档化

**边界情况文档模板**:

```markdown
# [模块名] 边界情况处理

## 1. 输入边界

### 1.1 空输入
- **场景**: 输入为空字符串/null/undefined
- **处理**: [具体处理方式]
- **返回值**: [返回值]
- **错误码**: [错误码]

### 1.2 超大输入
- **场景**: 输入超过 [大小限制]
- **处理**: [具体处理方式]
- **性能考虑**: [性能影响]

## 2. 并发边界

### 2.1 重复调用
- **场景**: 同一操作并发执行
- **处理**: [具体处理方式]
- **锁机制**: [锁实现]

### 2.2 资源竞争
- **场景**: 多个操作竞争同一资源
- **处理**: [具体处理方式]
- **死锁预防**: [预防措施]

## 3. 错误边界

### 3.1 网络错误
- **重试策略**: [重试次数和间隔]
- **降级方案**: [降级处理]
- **用户提示**: [提示信息]

### 3.2 资源不足
- **内存不足**: [处理方式]
- **磁盘不足**: [处理方式]
- **超时处理**: [超时策略]
```

### 3.5 代码探索技术

**并行探索策略**:
```typescript
// 同时启动多个探索代理
task(subagent_type="explore", prompt="分析状态管理系统...")
task(subagent_type="explore", prompt="分析工具系统...")
task(subagent_type="explore", prompt="分析智能体编排...")
task(subagent_type="explore", prompt="分析构建系统...")
```

**关键文件识别**:
```bash
# 查找入口文件
find src -name "index.ts" -o -name "main.ts" -o -name "*.tsx" | head -20

# 查找核心类/接口
grep -r "export.*interface\|export.*class" src --include="*.ts" | head -30

# 分析导入关系
grep -r "import.*from" src/[module] --include="*.ts" | grep -v "node_modules"
```

### 3.2 文档生成技术

**模板化生成**:
- 使用统一的文档模板
- 保持结构一致性
- 确保可追溯性

**代码示例提取**:
- 从源码提取关键代码片段
- 简化后作为示例
- 确保可运行性

### 3.3 质量保证技术

**完整性检查**:
```bash
# 统计文档数量
find output -name "*.md" | wc -l

# 检查文档大小
du -sh output/*

# 验证文档结构
ls -la output/01-需求文档/
ls -la output/02-架构设计/
ls -la output/03-模块设计/
```

**一致性检查**:
- 模块名称一致性
- 接口定义一致性
- 术语使用一致性

---

## 4. 实战案例

### 4.1 Claude Code项目文档化

**项目规模**:
- 1,902 源文件
- 513,237 行 TypeScript 代码
- 35+ 功能模块

**文档产出**:
- 33 个文档文件
- 900 KB 总大小
- 7 层文档结构

**关键成果**:
1. 识别了35个功能模块
2. 补充了KAIROS、ULTRAPLAN等隐藏功能
3. 详细设计了Session、Memory、Context压缩等核心机制
4. 提供了完整的重构指南和代码模板

### 4.2 文档使用案例

**场景1: 架构理解**
```
阅读顺序:
1. 产品需求总览.md - 了解产品背景
2. 系统架构总览.md - 理解整体架构
3. [模块]架构设计.md - 深入具体模块
```

**场景2: 功能开发**
```
阅读顺序:
1. [模块]-PRD.md - 了解需求
2. [模块]-详细设计.md - 查看设计
3. 代码模板.md - 获取模板
4. 测试用例.md - 编写测试
```

**场景3: 项目重构**
```
阅读顺序:
1. 重构指南.md - 了解策略
2. 实施清单.md - 按计划执行
3. 代码模板.md - 使用模板
4. 设计模式.md - 遵循模式
```

---

## 5. 工具使用

### 5.1 代码分析工具

**文件统计**:
```bash
# 统计文件数量
find src -type f \( -name "*.ts" -o -name "*.tsx" \) | wc -l

# 统计代码行数
find src -type f \( -name "*.ts" -o -name "*.tsx" \) | xargs wc -l | tail -1

# 按目录统计
find src -type d | while read dir; do
  echo "$dir: $(find $dir -type f | wc -l) files"
done
```

**依赖分析**:
```bash
# 分析导入关系
grep -r "import.*from" src --include="*.ts" | \
  sed 's/.*from "\(.*\)".*/\1/' | \
  sort | uniq -c | sort -rn | head -20
```

### 5.2 文档生成工具

**Markdown模板**:
```markdown
# [模块名] [文档类型]

**版本**: v1.0  
**最后更新**: YYYY-MM-DD

---

## 1. 概述

### 1.1 职责

### 1.2 核心概念

---

## 2. 架构设计

---

## 3. 详细设计

---

## 4. 代码示例

---

## 5. 相关文档

---

**文档结束**
```

---

## 6. 最佳实践

### 6.1 探索阶段

1. **先整体后局部** - 先了解整体架构，再深入模块
2. **并行探索** - 同时探索多个模块提高效率
3. **记录关键发现** - 及时记录重要的架构决策

### 6.2 文档生成阶段

1. **模板化** - 使用统一的文档模板
2. **中文优先** - 默认使用中文，除非特殊情况
3. **代码示例** - 提供可运行的代码示例
4. **图表辅助** - 使用 ASCII 图表辅助说明

### 6.3 验证阶段

1. **交叉验证** - 不同文档间相互验证
2. **抽样检查** - 随机抽查文档质量
3. **完整性统计** - 统计文档覆盖度

---

## 7. 常见问题

### Q1: 如何处理大型代码库？

**A**: 采用分层探索策略：
1. 第一层：识别主要模块
2. 第二层：分析模块间关系
3. 第三层：深入关键模块
4. 使用并行代理提高效率

### Q2: 如何保证文档质量？

**A**: 多维度质量保证：
1. 完整性检查清单
2. 跨文档一致性检查
3. 可重构性验证
4. 代码示例可运行性验证

### Q3: 如何处理缺失的文档？

**A**: 根据代码反推：
1. 从代码中提取功能点
2. 从接口推断架构
3. 从测试推断需求

### Q4: 如何保持文档更新？

**A**: 建立更新机制：
1. 代码变更触发文档更新
2. 定期文档审查
3. 版本控制文档

---

## 8. 总结

### 8.1 核心价值

1. **知识沉淀** - 将代码知识转化为文档
2. **降低门槛** - 新成员快速理解系统
3. **支撑重构** - 提供重构的完整依据
4. **便于维护** - 文档指导后续维护

### 8.2 成功要素

1. **系统化方法** - 遵循四阶段流程
2. **工具支持** - 使用自动化工具提高效率
3. **质量保证** - 多维度确保文档质量
4. **持续迭代** - 文档随代码持续更新

---

## 9. 附录

### 9.1 文档模板库

**PRD模板**:
```markdown
# [模块名] 需求规格说明书

## 1. 功能概述
## 2. 用户故事
## 3. 功能需求
## 4. 非功能需求
## 5. 接口需求
## 6. 验收标准
```

**可运行项目模板**:
```
project-root/
├── package.json              # 项目依赖和脚本
├── tsconfig.json             # TypeScript 配置
├── .env.example              # 环境变量模板
├── vitest.config.ts          # 测试配置
├── Dockerfile                # 容器配置
├── docker-compose.yml        # 编排配置
├── bin/
│   └── claude-haha          # 启动脚本
├── stubs/                    # 私有依赖存根
│   └── [dependency].ts
├── src/
│   └── [模块]/
│       └── __tests__/
│           └── [功能].test.ts
└── .github/
    └── workflows/
        ├── ci.yml           # CI 流程
        └── release.yml      # 发布流程
```

**架构设计模板**:
```markdown
# [模块名] 架构设计

## 1. 架构概述
## 2. 组件图
## 3. 数据流
## 4. 接口定义
## 5. 关键设计决策
## 6. 依赖关系
```

**详细设计模板**:
```markdown
# [模块名] 详细设计

## 1. 模块概述
## 2. 类/接口设计
## 3. 数据模型
## 4. 算法说明
## 5. 接口定义
## 6. 代码示例
```

### 9.3 完整重构补充指南

#### 9.3.1 文档完整性评估矩阵

```
                    文档完整度
                 低          高
           ┌──────────┬──────────┐
    高     │   谨慎   │   推荐   │
源         │  (bridge)│  (state) │
码         │  (buddy) │          │
复         ├──────────┼──────────┤
杂         │   避免   │   可行   │
度         │(QueryEng)│ (tools)  │
    低     │          │          │
           └──────────┴──────────┘
```

#### 9.3.2 重构成功率预测表

| 模块 | 重构成功率 | 主要风险 | 建议策略 |
|------|-----------|---------|---------|
| 简单模块 (state, buddy) | 90-95% | 低 | 可直接重构 |
| 中等模块 (tools, bridge) | 70-85% | 中 | 需要补充测试 |
| 复杂模块 (QueryEngine) | 40-60% | 高 | 需要详细设计 |
| 核心类型 | 85-95% | 低 | 可直接重构 |
| UI 组件 | 50-70% | 高 | 需要视觉设计 |

#### 9.3.3 必须补充的文档清单（完整重构版）

**🔴 Critical (必须，无此无法重构)**:
1. package.json (完整依赖列表和版本)
2. tsconfig.json (TypeScript 配置)
3. .env.example (环境变量模板)
4. bin/ 启动脚本 (可执行入口)
5. stubs/ 存根文件 (替代私有依赖)
6. 实际测试代码 (可运行的 __tests__/*.test.ts)
7. vitest.config.ts / jest.config.js (测试配置)
8. Dockerfile (容器配置)
9. docker-compose.yml (编排配置)
10. .github/workflows/ (CI/CD 工作流)
11. 入口文件详细设计
12. 核心类型完整定义

**🟡 High (重要，影响重构质量)**:
1. 依赖版本清单
2. 核心算法详细设计
3. 边界情况处理
4. 本地恢复模式 (Recovery CLI)
5. 运行指南文档

**🟢 Medium (建议，提高重构成功率)**:
1. 性能优化细节
2. 调试和日志系统
3. 监控和遥测
4. 国际化支持

#### 9.3.4 文档 vs 源码对比方法

```bash
# 1. 文件数量对比
echo "源码文件数: $(find analysis/src -name '*.ts' -o -name '*.tsx' | wc -l)"
echo "文档覆盖模块: $(ls output/03-模块设计/ | wc -l)"

# 2. 代码行数对比
echo "源码总行数: $(find analysis/src -name '*.ts' -o -name '*.tsx' | xargs wc -l | tail -1)"
echo "文档总行数: $(find output -name '*.md' | xargs wc -l | tail -1)"

# 3. 关键文件对比
for file in store.ts Tool.ts QueryEngine.ts; do
  if [ -f "analysis/src/$file" ]; then
    src_lines=$(wc -l < "analysis/src/$file")
    doc_coverage=$(grep -c "$file" output/03-模块设计/*.md 2>/dev/null || echo 0)
    echo "$file: 源码 $src_lines 行, 文档引用 $doc_coverage 次"
  fi
done
```

#### 9.3.5 重构前必须回答的问题

**配置文件**:
- [ ] package.json 中的依赖版本是什么？
- [ ] TypeScript 的严格模式配置是什么？
- [ ] 构建工具的入口和输出配置是什么？
- [ ] 测试框架和配置是什么？

**核心实现**:
- [ ] 状态机的所有状态和转换是否都定义了？
- [ ] 错误处理策略是什么（重试、降级、熔断）？
- [ ] 并发控制机制是什么？
- [ ] 性能优化点有哪些？

**测试验证**:
- [ ] 单元测试覆盖了哪些场景？
- [ ] 集成测试的测试数据是什么？
- [ ] E2E 测试的用户流程是什么？
- [ ] 性能测试的基准是什么？
- [ ] 测试文件是否可运行？

**部署和运行**:
- [ ] 如何本地运行项目？
- [ ] Docker 构建和运行命令是什么？
- [ ] CI/CD 流程如何配置？
- [ ] 降级模式（Recovery CLI）如何使用？

**边界情况**:
- [ ] 空输入如何处理？
- [ ] 超大输入如何处理？
- [ ] 网络错误如何重试？
- [ ] 资源不足如何降级？

---

**技能结束**
