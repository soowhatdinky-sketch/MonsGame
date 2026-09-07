param(
    [string]$Model = "nemotron-3-nano:4b",
    [int]$NumCtx = 2048,
    [int]$Repeat = 5,
    [string]$Prompt = "Reply with exactly three short bullet points about why compact local models are useful.",
    [string]$OllamaExe = "",
    [string]$UvExe = ""
)

$ErrorActionPreference = "Stop"

$tagsUrl = "http://127.0.0.1:11434/api/tags"

function Resolve-ExecutablePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [string]$ExplicitPath = "",
        [string]$EnvVarName = "",
        [string[]]$CandidatePaths = @()
    )

    $searchPaths = @()

    if ($ExplicitPath) {
        $searchPaths += $ExplicitPath
    }

    $envValue = $null
    if ($EnvVarName) {
        $envValue = [Environment]::GetEnvironmentVariable($EnvVarName)
    }

    if ($envValue) {
        $searchPaths += $envValue
    }

    $command = Get-Command -Name $Name -ErrorAction SilentlyContinue
    if ($command) {
        $searchPaths += $command.Source
    }

    $searchPaths += $CandidatePaths

    foreach ($path in ($searchPaths | Where-Object { $_ } | Select-Object -Unique)) {
        if (Test-Path $path) {
            return (Resolve-Path $path).Path
        }
    }

    throw "Unable to locate $Name. Set -$($Name.Substring(0,1).ToUpper() + $Name.Substring(1))Exe, define $EnvVarName, or add it to PATH."
}

function Test-OllamaReady {
    try {
        Invoke-RestMethod -Uri $tagsUrl -Method Get | Out-Null
        return $true
    }
    catch {
        return $false
    }
}

$userHome = [Environment]::GetFolderPath("UserProfile")
$ollamaCandidates = @(
    (Join-Path $userHome "AppData\Local\Programs\Ollama\ollama.exe"),
    "C:\Program Files\Ollama\ollama.exe"
)
$uvCandidates = @(
    (Join-Path $userHome ".local\bin\uv.exe"),
    (Join-Path $userHome "AppData\Roaming\Python\Scripts\uv.exe")
)

$ollama = Resolve-ExecutablePath -Name "ollama" -ExplicitPath $OllamaExe -EnvVarName "OLLAMA_EXE" -CandidatePaths $ollamaCandidates
$uv = Resolve-ExecutablePath -Name "uv" -ExplicitPath $UvExe -EnvVarName "UV_EXE" -CandidatePaths $uvCandidates

if (-not (Test-OllamaReady)) {
    Start-Process -FilePath $ollama -ArgumentList "serve" -WindowStyle Hidden | Out-Null
    for ($i = 0; $i -lt 30; $i++) {
        if (Test-OllamaReady) {
            break
        }
        Start-Sleep -Seconds 1
    }
}

if (-not (Test-OllamaReady)) {
    throw "Ollama did not become ready at $tagsUrl"
}

$tags = Invoke-RestMethod -Uri $tagsUrl -Method Get
$installed = @($tags.models | ForEach-Object { $_.name })
if ($installed -notcontains $Model) {
    & $ollama pull $Model
}

$env:PATH = "{0};{1}" -f (Split-Path -Parent $uv), $env:PATH
& $uv run .\benchmark_ollama.py --model $Model --num-ctx $NumCtx --repeat $Repeat --prompt $Prompt
