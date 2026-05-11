#!/bin/bash

# dev-skills 安装脚本
# 支持: Claude Code, OpenCode, Trae, Codex, Gemini CLI, Cursor, Windsurf

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 技能信息
SKILL_REPO="https://github.com/deepload-ai/dev-skills.git"
SKILL_NAME="dev-skills"

# 安装状态追踪
INSTALLED_COUNT=0
SKIPPED_COUNT=0
FAILED_COUNT=0

# 打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 检查目录是否存在
dir_exists() {
    [ -d "$1" ]
}

# ==================== Claude Code ====================
install_claude_code() {
    print_info "检查 Claude Code..."
    
    # Claude Code 技能目录
    CLAUDE_SKILLS_DIR="$HOME/.claude/skills"
    
    # 检查 Claude Code 是否安装（通过检查目录或命令）
    if ! dir_exists "$HOME/.claude" && ! command_exists "claude"; then
        print_warning "Claude Code 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # 确保目录存在
    mkdir -p "$CLAUDE_SKILLS_DIR"
    
    # 安装技能
    local target_dir="$CLAUDE_SKILLS_DIR/$SKILL_NAME"
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "Claude Code 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== OpenCode ====================
install_opencode() {
    print_info "检查 OpenCode..."
    
    # OpenCode 技能目录（多种可能路径）
    OPENCODE_SKILLS_DIRS=(
        "$HOME/.agents/skills"
        "$HOME/.opencode/skills"
        "$HOME/.config/opencode/skills"
    )
    
    # 检查 OpenCode 是否安装
    local opencode_found=false
    for dir in "${OPENCODE_SKILLS_DIRS[@]}"; do
        if dir_exists "$dir" || dir_exists "${dir%/skills}"; then
            opencode_found=true
            break
        fi
    done
    
    if ! $opencode_found && ! command_exists "opencode"; then
        print_warning "OpenCode 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # 使用第一个存在的目录，或创建默认目录
    local target_dir=""
    for dir in "${OPENCODE_SKILLS_DIRS[@]}"; do
        if dir_exists "$dir" || dir_exists "${dir%/skills}"; then
            target_dir="$dir/$SKILL_NAME"
            break
        fi
    done
    
    # 如果都没找到，使用默认路径
    if [ -z "$target_dir" ]; then
        target_dir="${OPENCODE_SKILLS_DIRS[0]}/$SKILL_NAME"
        mkdir -p "${OPENCODE_SKILLS_DIRS[0]}"
    fi
    
    # 安装技能
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "OpenCode 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== Trae ====================
install_trae() {
    print_info "检查 Trae..."
    
    # Trae 可能的配置目录
    TRAE_DIRS=(
        "$HOME/.trae"
        "$HOME/Library/Application Support/Trae"  # macOS
        "$HOME/AppData/Roaming/Trae"              # Windows
        "$HOME/.config/Trae"                      # Linux
    )
    
    # 检查 Trae 是否安装
    local trae_found=false
    for dir in "${TRAE_DIRS[@]}"; do
        if dir_exists "$dir"; then
            trae_found=true
            break
        fi
    done
    
    if ! $trae_found && ! command_exists "trae"; then
        print_warning "Trae 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # Trae 使用 .trae/skills 目录
    local target_dir="$HOME/.trae/skills/$SKILL_NAME"
    mkdir -p "$HOME/.trae/skills"
    
    # 安装技能
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "Trae 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== Codex CLI ====================
install_codex() {
    print_info "检查 Codex CLI..."
    
    # Codex 配置目录
    CODEX_DIRS=(
        "$HOME/.codex"
        "$HOME/.config/codex"
    )
    
    # 检查 Codex 是否安装
    local codex_found=false
    for dir in "${CODEX_DIRS[@]}"; do
        if dir_exists "$dir"; then
            codex_found=true
            break
        fi
    done
    
    if ! $codex_found && ! command_exists "codex"; then
        print_warning "Codex CLI 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # Codex 使用 .codex/skills 目录
    local target_dir="$HOME/.codex/skills/$SKILL_NAME"
    mkdir -p "$HOME/.codex/skills"
    
    # 安装技能
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "Codex CLI 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== Gemini CLI ====================
install_gemini() {
    print_info "检查 Gemini CLI..."
    
    # Gemini 配置目录
    GEMINI_DIRS=(
        "$HOME/.gemini"
        "$HOME/.config/gemini"
        "$HOME/.google/gemini"
    )
    
    # 检查 Gemini 是否安装
    local gemini_found=false
    for dir in "${GEMINI_DIRS[@]}"; do
        if dir_exists "$dir"; then
            gemini_found=true
            break
        fi
    done
    
    if ! $gemini_found && ! command_exists "gemini"; then
        print_warning "Gemini CLI 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # Gemini 使用 .gemini/skills 目录
    local target_dir="$HOME/.gemini/skills/$SKILL_NAME"
    mkdir -p "$HOME/.gemini/skills"
    
    # 安装技能
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "Gemini CLI 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== Cursor ====================
install_cursor() {
    print_info "检查 Cursor..."
    
    # Cursor 配置目录
    CURSOR_DIRS=(
        "$HOME/.cursor"
        "$HOME/Library/Application Support/Cursor"  # macOS
        "$HOME/AppData/Roaming/Cursor"              # Windows
        "$HOME/.config/Cursor"                      # Linux
    )
    
    # 检查 Cursor 是否安装
    local cursor_found=false
    for dir in "${CURSOR_DIRS[@]}"; do
        if dir_exists "$dir"; then
            cursor_found=true
            break
        fi
    done
    
    if ! $cursor_found && ! command_exists "cursor"; then
        print_warning "Cursor 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # Cursor 使用 .cursor/skills 目录
    local target_dir="$HOME/.cursor/skills/$SKILL_NAME"
    mkdir -p "$HOME/.cursor/skills"
    
    # 安装技能
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "Cursor 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== Windsurf ====================
install_windsurf() {
    print_info "检查 Windsurf..."
    
    # Windsurf 配置目录
    WINDSURF_DIRS=(
        "$HOME/.windsurf"
        "$HOME/Library/Application Support/Windsurf"  # macOS
        "$HOME/AppData/Roaming/Windsurf"              # Windows
        "$HOME/.config/Windsurf"                      # Linux
    )
    
    # 检查 Windsurf 是否安装
    local windsurf_found=false
    for dir in "${WINDSURF_DIRS[@]}"; do
        if dir_exists "$dir"; then
            windsurf_found=true
            break
        fi
    done
    
    if ! $windsurf_found && ! command_exists "windsurf"; then
        print_warning "Windsurf 未安装，跳过"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        return 1
    fi
    
    # Windsurf 使用 .windsurf/skills 目录
    local target_dir="$HOME/.windsurf/skills/$SKILL_NAME"
    mkdir -p "$HOME/.windsurf/skills"
    
    # 安装技能
    if dir_exists "$target_dir"; then
        print_info "更新已存在的技能目录..."
        cd "$target_dir" && git pull --quiet
    else
        print_info "克隆技能仓库..."
        git clone --quiet "$SKILL_REPO" "$target_dir"
    fi
    
    print_success "Windsurf 技能安装完成: $target_dir"
    INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    return 0
}

# ==================== 通用安装（未知工具） ====================
install_generic() {
    print_info "检查通用 AI Coding 工具..."
    
    # 尝试在常见位置安装
    GENERIC_DIRS=(
        "$HOME/.ai/skills"
        "$HOME/.coding/skills"
        "$HOME/.llm/skills"
    )
    
    local installed_any=false
    for dir in "${GENERIC_DIRS[@]}"; do
        if dir_exists "${dir%/skills}" || [ "$FORCE_INSTALL" = "true" ]; then
            mkdir -p "$dir"
            local target_dir="$dir/$SKILL_NAME"
            
            if dir_exists "$target_dir"; then
                print_info "更新已存在的技能目录: $target_dir"
                cd "$target_dir" && git pull --quiet 2>/dev/null || true
            else
                print_info "克隆技能仓库到: $target_dir"
                git clone --quiet "$SKILL_REPO" "$target_dir" 2>/dev/null || continue
            fi
            
            print_success "通用安装完成: $target_dir"
            $installed_any || INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
            installed_any=true
        fi
    done
    
    if ! $installed_any; then
        print_warning "未找到通用 AI Coding 工具配置目录"
        return 1
    fi
    
    return 0
}

# ==================== 主程序 ====================

# 打印 banner
echo "========================================"
echo "  dev-skills 安装脚本"
echo "  支持: Claude Code, OpenCode, Trae,"
echo "        Codex, Gemini, Cursor, Windsurf"
echo "========================================"
echo ""

# 检查 git
if ! command_exists git; then
    print_error "请先安装 Git"
    exit 1
fi

# 解析参数
FORCE_INSTALL=false
SPECIFIC_TOOL=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        --tool)
            SPECIFIC_TOOL="$2"
            shift 2
            ;;
        --help|-h)
            echo "用法: $0 [选项]"
            echo ""
            echo "选项:"
            echo "  --tool <工具名>    只安装到指定工具 (claude|opencode|trae|codex|gemini|cursor|windsurf)"
            echo "  --force            强制安装，即使未检测到工具"
            echo "  --help, -h         显示帮助信息"
            echo ""
            echo "示例:"
            echo "  $0                 # 自动检测并安装到所有已安装的工具"
            echo "  $0 --tool claude   # 只安装到 Claude Code"
            echo "  $0 --force         # 强制安装到所有默认位置"
            exit 0
            ;;
        *)
            print_error "未知参数: $1"
            exit 1
            ;;
    esac
done

# 根据参数执行安装
if [ -n "$SPECIFIC_TOOL" ]; then
    case "$SPECIFIC_TOOL" in
        claude)
            install_claude_code || exit 1
            ;;
        opencode)
            install_opencode || exit 1
            ;;
        trae)
            install_trae || exit 1
            ;;
        codex)
            install_codex || exit 1
            ;;
        gemini)
            install_gemini || exit 1
            ;;
        cursor)
            install_cursor || exit 1
            ;;
        windsurf)
            install_windsurf || exit 1
            ;;
        *)
            print_error "未知工具: $SPECIFIC_TOOL"
            print_info "支持的工具: claude, opencode, trae, codex, gemini, cursor, windsurf"
            exit 1
            ;;
    esac
else
    # 自动检测并安装到所有已安装的工具
    install_claude_code || true
    install_opencode || true
    install_trae || true
    install_codex || true
    install_gemini || true
    install_cursor || true
    install_windsurf || true
    
    # 如果没有安装任何工具，尝试通用安装
    if [ $INSTALLED_COUNT -eq 0 ] && [ "$FORCE_INSTALL" = "true" ]; then
        install_generic || true
    fi
fi

# 打印总结
echo ""
echo "========================================"
echo "  安装总结"
echo "========================================"
echo -e "  ${GREEN}成功安装: $INSTALLED_COUNT${NC}"
echo -e "  ${YELLOW}跳过: $SKIPPED_COUNT${NC}"
echo -e "  ${RED}失败: $FAILED_COUNT${NC}"
echo ""

if [ $INSTALLED_COUNT -eq 0 ]; then
    print_warning "未检测到任何已安装的 AI Coding 工具"
    echo ""
    echo "支持的工具有:"
    echo "  • Claude Code (https://claude.ai/code)"
    echo "  • OpenCode (https://opencode.ai)"
    echo "  • Trae (https://trae.ai)"
    echo "  • Codex CLI (https://github.com/openai/codex)"
    echo "  • Gemini CLI (https://ai.google.dev/gemini-api)"
    echo "  • Cursor (https://cursor.sh)"
    echo "  • Windsurf (https://windsurf.io)"
    echo ""
    echo "如果已安装但未被检测到，可以使用 --force 参数强制安装:"
    echo "  $0 --force"
    echo ""
    echo "或者指定特定工具:"
    echo "  $0 --tool claude"
    exit 1
else
    print_success "安装完成！"
    echo ""
    echo "可用的技能:"
    echo "  • refactor2docs - 代码转文档重构"
    echo "  • docs2prd      - 文档转PRD生成"
    echo "  • skill-check   - 技能质量审查与迭代"
    echo ""
    echo "使用方法:"
    echo "  在 AI Coding 工具中直接引用技能名称即可触发"
fi
