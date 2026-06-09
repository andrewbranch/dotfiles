# --- Aliases ---
Set-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue
Set-Alias -Name vi -Value nvim -ErrorAction SilentlyContinue
Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -Value New-Item
Set-Alias -Name ll -Value Get-ChildItem

# --- Useful defaults ---

# Unix-like 'head' for PowerShell
function head { param([int]$n = 10) $input | Select-Object -First $n }

# Unix-like 'tail' for PowerShell
function tail { param([int]$n = 10) $input | Select-Object -Last $n }

# Quick directory navigation
function .. { Set-Location .. }
function ... { Set-Location ../.. }

# mkcd: create and enter a directory
function mkcd { param([string]$dir) New-Item -ItemType Directory -Path $dir -Force | Out-Null; Set-Location $dir }

# Open Windows Terminal settings
function Edit-Profile { nvim $PROFILE }

# Git shorthand
function gs { git status @args }
function gd { git diff @args }
function gl { git log --oneline -20 @args }

# --- PSReadLine (better editing experience) ---
if (Get-Module -ListAvailable -Name PSReadLine) {
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    if ((Get-Module PSReadLine).Version -ge [version]"2.2.0") {
        Set-PSReadLineOption -PredictionSource History
        # Tab accepts ghost text prediction when visible, otherwise does normal completion
        Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {
            param($key, $arg)
            $line = $null
            $cursor = $null
            [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
            if ($line.Length -gt 0 -and $cursor -ge $line.Length) {
                [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
            } else {
                [Microsoft.PowerShell.PSConsoleReadLine]::MenuComplete($key, $arg)
            }
        }
    } else {
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
    }
}

# --- Prompt (starship) ---
Invoke-Expression (&starship init powershell)
