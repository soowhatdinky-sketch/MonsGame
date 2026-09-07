<div align="center">

![Nemotron Nano Identity](./assets/nano-identity.svg)

# Nemotron-3-Nano Sandbox

Reproducible local benchmark workspace for `nemotron-3-nano:4b` on Windows with Ollama and `uv`.

</div>

![Model](https://img.shields.io/badge/Model-nemotron--3--nano%3A4b-0ea5e9?style=for-the-badge)
![Context](https://img.shields.io/badge/Context-2048-0ea5e9?style=for-the-badge)
![Repeat](https://img.shields.io/badge/Repeat-5-0ea5e9?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-14b8a6?style=for-the-badge)

[English](README.md) | [Japanese](README.ja.md)

## Overview

- Last benchmark timestamp: `2026-03-25 21:09:15 +09:00`
- Model tag: `nemotron-3-nano:4b`
- Ollama: `0.18.2`
- uv: `0.10.8`
- Shell: `PowerShell`
- GPU: `NVIDIA GeForce RTX 3060 Laptop GPU`
- Context length: `2048`
- Repeat count: `5`
- Source of truth: [`benchmark_latest.json`](./benchmark_latest.json)

Additional evidence files:

- [`ollama_ps.txt`](./ollama_ps.txt): `SIZE 5.2 GB`, `14%/86% CPU/GPU`, `CONTEXT 2048`
- [`nvidia_smi.txt`](./nvidia_smi.txt): `5838 MiB / 6144 MiB` snapshot at capture time
- [`ollama_version.txt`](./ollama_version.txt), [`uv_version.txt`](./uv_version.txt), [`benchmark_timestamp.txt`](./benchmark_timestamp.txt)

## Purpose

- Confirm that `nemotron-3-nano:4b` can run locally on this workstation through Ollama.
- Preserve one benchmark run as auditable evidence rather than relying on anecdotal notes.
- Provide a repeatable Windows wrapper and a minimal Python harness for future reruns.

## Prerequisites

- Windows with PowerShell
- Ollama installed locally
- `uv` installed locally

`run_benchmark.ps1` resolves executables in this order:

1. Explicit parameters `-OllamaExe` and `-UvExe`
2. Environment variables `OLLAMA_EXE` and `UV_EXE`
3. `PATH`
4. Common Windows install paths for Ollama and `uv`

## Quick Start

Primary command:

```powershell
.\run_benchmark.ps1 -Model nemotron-3-nano:4b -NumCtx 2048 -Repeat 5
```

Override executable paths when needed:

```powershell
.\run_benchmark.ps1 `
  -OllamaExe "C:\Users\<you>\AppData\Local\Programs\Ollama\ollama.exe" `
  -UvExe "C:\Users\<you>\.local\bin\uv.exe"
```

Use environment variables instead of parameters:

```powershell
$env:OLLAMA_EXE = "C:\Users\<you>\AppData\Local\Programs\Ollama\ollama.exe"
$env:UV_EXE = "C:\Users\<you>\.local\bin\uv.exe"
.\run_benchmark.ps1
```

Run the Python benchmark directly:

```powershell
uv run .\benchmark_ollama.py --model nemotron-3-nano:4b --num-ctx 2048 --repeat 5
```

Open a direct chat session:

```powershell
ollama run nemotron-3-nano:4b
```

Default prompt:

```text
Reply with exactly three short bullet points about why compact local models are useful.
```

## Results

Aggregate metrics from [`benchmark_latest.json`](./benchmark_latest.json):

| Metric | Value |
| --- | --- |
| `eval_rate_tps_avg` | `33.13 tok/s` |
| `eval_rate_tps_median` | `33.85 tok/s` |
| `eval_rate_tps_min` | `28.86 tok/s` |
| `eval_rate_tps_max` | `36.06 tok/s` |
| `total_seconds_avg` | `4.058 s` |
| `load_seconds_avg` | `0.378 s` |

Run-level detail:

| Run | `total_seconds` | `load_seconds` | `eval_rate_tps` |
| --- | --- | --- | --- |
| 1 | `4.187 s` | `0.310 s` | `32.81 tok/s` |
| 2 | `5.311 s` | `0.381 s` | `34.05 tok/s` |
| 3 | `2.965 s` | `0.284 s` | `36.06 tok/s` |
| 4 | `2.821 s` | `0.302 s` | `28.86 tok/s` |
| 5 | `5.006 s` | `0.612 s` | `33.85 tok/s` |

Illustrative `visible_response_preview` sample:

```text
- Runs locally, no data transmission.
- Low size reduces memory usage.
- Faster inference, no network latency.
```

This text is model output and is included only as a trace sample.

## Repository Layout

- [`benchmark_ollama.py`](./benchmark_ollama.py): JSON benchmark runner for `/api/generate`
- [`run_benchmark.ps1`](./run_benchmark.ps1): Windows wrapper that waits for Ollama readiness and invokes `uv run`
- [`benchmark_latest.json`](./benchmark_latest.json): latest recorded benchmark result
- [`assets/nano-identity.svg`](./assets/nano-identity.svg): repository identity asset
- [`.github/workflows/repo-scaffold-checks.yml`](./.github/workflows/repo-scaffold-checks.yml): GPU-free structural checks for CI

## Notes

- [`benchmark_ollama.py`](./benchmark_ollama.py) strips pre-`</think>` content into `visible_response_preview` for cleaner reporting.
- The repository keeps evidence files under version control so README claims can be traced to saved artifacts.
- The wrapper is Windows-oriented, but it no longer depends on one hardcoded workstation path.

## Limitations

- Only one short prompt family is measured.
- The benchmark reflects this local machine and captured session, not a universal performance claim.
- `ollama ps` values are recorded as observed output; GPU offload internals were not deeply validated.
- Cold-start-only behavior, long-running stability, and cross-model comparisons are outside this pass.

## Next Steps

- Separate cold-start and warm-start measurements.
- Add English and Japanese prompt comparisons under the same JSON schema.
- Extend the same evidence format to additional local model tags.
