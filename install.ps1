# dev-skills 安装脚本 (PowerShell)
# 支持: Claude Code, OpenCode, Trae, Codex, Gemini CLI, Cursor, Windsurf

param(
    [string]$Tool = "",
    [switch]$Force,
    [switch]$Help
)

# 颜色定义
$Red = "`e[31m"
$Green = "`e[32m"
$Yellow = "`e[33m"
$Blue = "`e[34m"
$NC = "`e[0m"

# 技能信息
$SkillRepo = "https://github.com/deepload-ai/dev-skills.git"
$SkillName = "dev-skills"

# 安装状态追踪
$InstalledCount = 0
$SkippedCount = 0
$FailedCount = 0

# 打印带颜色的消息
function Print-Info { param($msg) Write-Host "${Blue}[INFO]${NC} $msg" }
function Print-Success { param($msg) Write-Host "${Green}[SUCCESS]${NC} $msg" }
function Print-Warning { param($msg) Write-Host "${Yellow}[WARNING]${NC} $msg" }
function Print-Error { param($msg) Write-Host "${Red}[ERROR]${NC} $msg" }

# 检查命令是否存在
function Command-Exists { param($cmd) return [bool](Get-Command -Name $cmd -ErrorAction SilentlyContinue) }

# 检查目录是否存在
function Dir-Exists { param($path) return Test-Path -Path $path -PathType Container }

# ==================== Claude Code ====================
function Install-ClaudeCode {
    Print-Info "检查 Claude Code..."
    
    $claudeSkillsDir = "$env:USERPROFILE\.claude\skills"
    
    if (-not (Dir-Exists "$env:USERPROFILE\.claude") -and -not (Command-Exists "claude")) {
        Print-Warning "Claude Code 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    New-Item -ItemType Directory -Force -Path $claudeSkillsDir | Out-Null
    
    $targetDir = "$claudeSkillsDir\$SkillName"
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "Claude Code 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== OpenCode ====================
function Install-OpenCode {
    Print-Info "检查 OpenCode..."
    
    $opencodeDirs = @(
        "$env:USERPROFILE\.agents\skills",
        "$env:USERPROFILE\.opencode\skills",
        "$env:USERPROFILE\.config\opencode\skills"
    )
    
    $opencodeFound = $false
    foreach ($dir in $opencodeDirs) {
        if (Dir-Exists $dir -or (Dir-Exists ($dir -replace '\\skills$', ''))) {
            $opencodeFound = $true
            break
        }
    }
    
    if (-not $opencodeFound -and -not (Command-Exists "opencode")) {
        Print-Warning "OpenCode 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    $targetDir = $null
    foreach ($dir in $opencodeDirs) {
        if (Dir-Exists $dir -or (Dir-Exists ($dir -replace '\\skills$', ''))) {
            $targetDir = "$dir\$SkillName"
            break
        }
    }
    
    if (-not $targetDir) {
        $targetDir = "$($opencodeDirs[0])\$SkillName"
        New-Item -ItemType Directory -Force -Path $opencodeDirs[0] | Out-Null
    }
    
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "OpenCode 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== Trae ====================
function Install-Trae {
    Print-Info "检查 Trae..."
    
    $traeDirs = @(
        "$env:USERPROFILE\.trae",
        "$env:APPDATA\Trae",
        "$env:USERPROFILE\AppData\Roaming\Trae"
    )
    
    $traeFound = $false
    foreach ($dir in $traeDirs) {
        if (Dir-Exists $dir) {
            $traeFound = $true
            break
        }
    }
    
    if (-not $traeFound -and -not (Command-Exists "trae")) {
        Print-Warning "Trae 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    $targetDir = "$env:USERPROFILE\.trae\skills\$SkillName"
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.trae\skills" | Out-Null
    
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "Trae 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== Codex CLI ====================
function Install-Codex {
    Print-Info "检查 Codex CLI..."
    
    $codexDirs = @(
        "$env:USERPROFILE\.codex",
        "$env:USERPROFILE\.config\codex"
    )
    
    $codexFound = $false
    foreach ($dir in $codexDirs) {
        if (Dir-Exists $dir) {
            $codexFound = $true
            break
        }
    }
    
    if (-not $codexFound -and -not (Command-Exists "codex")) {
        Print-Warning "Codex CLI 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    $targetDir = "$env:USERPROFILE\.codex\skills\$SkillName"
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\skills" | Out-Null
    
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "Codex CLI 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== Gemini CLI ====================
function Install-Gemini {
    Print-Info "检查 Gemini CLI..."
    
    $geminiDirs = @(
        "$env:USERPROFILE\.gemini",
        "$env:USERPROFILE\.config\gemini",
        "$env:USERPROFILE\.google\gemini"
    )
    
    $geminiFound = $false
    foreach ($dir in $geminiDirs) {
        if (Dir-Exists $dir) {
            $geminiFound = $true
            break
        }
    }
    
    if (-not $geminiFound -and -not (Command-Exists "gemini")) {
        Print-Warning "Gemini CLI 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    $targetDir = "$env:USERPROFILE\.gemini\skills\$SkillName"
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills" | Out-Null
    
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "Gemini CLI 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== Cursor ====================
function Install-Cursor {
    Print-Info "检查 Cursor..."
    
    $cursorDirs = @(
        "$env:USERPROFILE\.cursor",
        "$env:APPDATA\Cursor",
        "$env:USERPROFILE\AppData\Roaming\Cursor"
    )
    
    $cursorFound = $false
    foreach ($dir in $cursorDirs) {
        if (Dir-Exists $dir) {
            $cursorFound = $true
            break
        }
    }
    
    if (-not $cursorFound -and -not (Command-Exists "cursor")) {
        Print-Warning "Cursor 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    $targetDir = "$env:USERPROFILE\.cursor\skills\$SkillName"
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.cursor\skills" | Out-Null
    
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "Cursor 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== Windsurf ====================
function Install-Windsurf {
    Print-Info "检查 Windsurf..."
    
    $windsurfDirs = @(
        "$env:USERPROFILE\.windsurf",
        "$env:APPDATA\Windsurf",
        "$env:USERPROFILE\AppData\Roaming\Windsurf"
    )
    
    $windsurfFound = $false
    foreach ($dir in $windsurfDirs) {
        if (Dir-Exists $dir) {
            $windsurfFound = $true
            break
        }
    }
    
    if (-not $windsurfFound -and -not (Command-Exists "windsurf")) {
        Print-Warning "Windsurf 未安装，跳过"
        $script:SkippedCount++
        return $false
    }
    
    $targetDir = "$env:USERPROFILE\.windsurf\skills\$SkillName"
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.windsurf\skills" | Out-Null
    
    if (Dir-Exists $targetDir) {
        Print-Info "更新已存在的技能目录..."
        Set-Location $targetDir
        git pull --quiet 2>$null
    } else {
        Print-Info "克隆技能仓库..."
        git clone --quiet $SkillRepo $targetDir 2>$null
    }
    
    Print-Success "Windsurf 技能安装完成: $targetDir"
    $script:InstalledCount++
    return $true
}

# ==================== 主程序 ====================

# 打印 banner
Write-Host "========================================"
Write-Host "  dev-skills 安装脚本 (Windows)"
Write-Host "  支持: Claude Code, OpenCode, Trae,"
Write-Host "        Codex, Gemini, Cursor, Windsurf"
Write-Host "========================================"
Write-Host ""

# 显示帮助
if ($Help) {
    Write-Host "用法: .\install.ps1 [选项]"
    Write-Host ""
    Write-Host "选项:"
    Write-Host "  -Tool <工具名>    只安装到指定工具 (claude|opencode|trae|codex|gemini|cursor|windsurf)"
    Write-Host "  -Force            强制安装，即使未检测到工具"
    Write-Host "  -Help             显示帮助信息"
    Write-Host ""
    Write-Host "示例:"
    Write-Host "  .\install.ps1                 # 自动检测并安装到所有已安装的工具"
    Write-Host "  .\install.ps1 -Tool claude    # 只安装到 Claude Code"
    Write-Host "  .\install.ps1 -Force          # 强制安装到所有默认位置"
    exit 0
}

# 检查 git
if (-not (Command-Exists "git")) {
    Print-Error "请先安装 Git"
    exit 1
}

# 根据参数执行安装
if ($Tool) {
    switch ($Tool.ToLower()) {
        "claude" { Install-ClaudeCode | Out-Null }
        "opencode" { Install-OpenCode | Out-Null }
        "trae" { Install-Trae | Out-Null }
        "codex" { Install-Codex | Out-Null }
        "gemini" { Install-Gemini | Out-Null }
        "cursor" { Install-Cursor | Out-Null }
        "windsurf" { Install-Windsurf | Out-Null }
        default {
            Print-Error "未知工具: $Tool"
            Print-Info "支持的工具: claude, opencode, trae, codex, gemini, cursor, windsurf"
            exit 1
        }
    }
} else {
    # 自动检测并安装到所有已安装的工具
    Install-ClaudeCode | Out-Null
    Install-OpenCode | Out-Null
    Install-Trae | Out-Null
    Install-Codex | Out-Null
    Install-Gemini | Out-Null
    Install-Cursor | Out-Null
    Install-Windsurf | Out-Null
}

# 打印总结
Write-Host ""
Write-Host "========================================"
Write-Host "  安装总结"
Write-Host "========================================"
Write-Host "  成功安装: $InstalledCount"
Write-Host "  跳过: $SkippedCount"
Write-Host "  失败: $FailedCount"
Write-Host ""

if ($InstalledCount -eq 0) {
    Print-Warning "未检测到任何已安装的 AI Coding 工具"
    Write-Host ""
    Write-Host "支持的工具有:"
    Write-Host "  • Claude Code (https://claude.ai/code)"
    Write-Host "  • OpenCode (https://opencode.ai)"
    Write-Host "  • Trae (https://trae.ai)"
    Write-Host "  • Codex CLI (https://github.com/openai/codex)"
    Write-Host "  • Gemini CLI (https://ai.google.dev/gemini-api)"
    Write-Host "  • Cursor (https://cursor.sh)"
    Write-Host "  • Windsurf (https://windsurf.io)"
    Write-Host ""
    Write-Host "如果已安装但未被检测到，可以使用 -Force 参数强制安装:"
    Write-Host "  .\install.ps1 -Force"
    Write-Host ""
    Write-Host "或者指定特定工具:"
    Write-Host "  .\install.ps1 -Tool claude"
    exit 1
} else {
    Print-Success "安装完成！"
    Write-Host ""
    Write-Host "可用的技能:"
    Write-Host "  • refactor2docs - 代码转文档重构"
    Write-Host "  • docs2prd      - 文档转PRD生成"
    Write-Host "  • skill-check   - 技能质量审查与迭代"
    Write-Host ""
    Write-Host "使用方法:"
    Write-Host "  在 AI Coding 工具中直接引用技能名称即可触发"
}
