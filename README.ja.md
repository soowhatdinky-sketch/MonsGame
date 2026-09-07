<div align="center">

![Nemotron Nano Identity](./assets/nano-identity.svg)

# Nemotron-3-Nano Sandbox

Windows 上で `nemotron-3-nano:4b` を Ollama と `uv` でローカル実行し、再現可能な形でベンチマーク記録を残すためのリポジトリです。

</div>

![Model](https://img.shields.io/badge/Model-nemotron--3--nano%3A4b-0ea5e9?style=for-the-badge)
![Context](https://img.shields.io/badge/Context-2048-0ea5e9?style=for-the-badge)
![Repeat](https://img.shields.io/badge/Repeat-5-0ea5e9?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-14b8a6?style=for-the-badge)

[English](README.md) | [日本語](README.ja.md)

## 概要

- ベンチマーク実行日時: `2026-03-25 21:09:15 +09:00`
- モデルタグ: `nemotron-3-nano:4b`
- Ollama: `0.18.2`
- uv: `0.10.8`
- シェル: `PowerShell`
- GPU: `NVIDIA GeForce RTX 3060 Laptop GPU`
- コンテキスト長: `2048`
- 反復回数: `5`
- 数値の正本: [`benchmark_latest.json`](./benchmark_latest.json)

補助的な証跡ファイル:

- [`ollama_ps.txt`](./ollama_ps.txt): `SIZE 5.2 GB`, `14%/86% CPU/GPU`, `CONTEXT 2048`
- [`nvidia_smi.txt`](./nvidia_smi.txt): 取得時点の `5838 MiB / 6144 MiB`
- [`ollama_version.txt`](./ollama_version.txt), [`uv_version.txt`](./uv_version.txt), [`benchmark_timestamp.txt`](./benchmark_timestamp.txt)

## 目的

- `nemotron-3-nano:4b` がこの PC 上で Ollama 経由で動作することを確認する
- 口頭メモではなく、追跡可能な証跡として 1 回分のベンチマーク結果を保存する
- 将来の再実行に使える Windows ラッパーと最小限の Python ハーネスを用意する

## 前提条件

- Windows と PowerShell
- ローカルにインストールされた Ollama
- ローカルにインストールされた `uv`

`run_benchmark.ps1` は次の順番で実行ファイルを解決します。

1. 明示パラメータ `-OllamaExe` と `-UvExe`
2. 環境変数 `OLLAMA_EXE` と `UV_EXE`
3. `PATH`
4. Ollama と `uv` の代表的な Windows インストール先

## 実行方法

基本コマンド:

```powershell
.\run_benchmark.ps1 -Model nemotron-3-nano:4b -NumCtx 2048 -Repeat 5
```

実行ファイルの場所を明示する場合:

```powershell
.\run_benchmark.ps1 `
  -OllamaExe "C:\Users\<you>\AppData\Local\Programs\Ollama\ollama.exe" `
  -UvExe "C:\Users\<you>\.local\bin\uv.exe"
```

環境変数で指定する場合:

```powershell
$env:OLLAMA_EXE = "C:\Users\<you>\AppData\Local\Programs\Ollama\ollama.exe"
$env:UV_EXE = "C:\Users\<you>\.local\bin\uv.exe"
.\run_benchmark.ps1
```

Python ハーネスを直接実行する場合:

```powershell
uv run .\benchmark_ollama.py --model nemotron-3-nano:4b --num-ctx 2048 --repeat 5
```

モデルと対話するだけなら:

```powershell
ollama run nemotron-3-nano:4b
```

既定のプロンプト:

```text
Reply with exactly three short bullet points about why compact local models are useful.
```

## 結果

[`benchmark_latest.json`](./benchmark_latest.json) に記録した集計値:

| 指標 | 値 |
| --- | --- |
| `eval_rate_tps_avg` | `33.13 tok/s` |
| `eval_rate_tps_median` | `33.85 tok/s` |
| `eval_rate_tps_min` | `28.86 tok/s` |
| `eval_rate_tps_max` | `36.06 tok/s` |
| `total_seconds_avg` | `4.058 s` |
| `load_seconds_avg` | `0.378 s` |

各 run の値:

| Run | `total_seconds` | `load_seconds` | `eval_rate_tps` |
| --- | --- | --- | --- |
| 1 | `4.187 s` | `0.310 s` | `32.81 tok/s` |
| 2 | `5.311 s` | `0.381 s` | `34.05 tok/s` |
| 3 | `2.965 s` | `0.284 s` | `36.06 tok/s` |
| 4 | `2.821 s` | `0.302 s` | `28.86 tok/s` |
| 5 | `5.006 s` | `0.612 s` | `33.85 tok/s` |

`visible_response_preview` の例:

```text
- Runs locally, no data transmission.
- Low size reduces memory usage.
- Faster inference, no network latency.
```

これはモデルの生成例であり、性能そのものの証明ではありません。

## リポジトリ構成

- [`benchmark_ollama.py`](./benchmark_ollama.py): `/api/generate` を呼び出す JSON ベンチマーク実行スクリプト
- [`run_benchmark.ps1`](./run_benchmark.ps1): Ollama API の起動確認後に `uv run` を呼ぶ Windows ラッパー
- [`benchmark_latest.json`](./benchmark_latest.json): 最新の記録結果
- [`assets/nano-identity.svg`](./assets/nano-identity.svg): リポジトリ用の識別アセット
- [`.github/workflows/repo-scaffold-checks.yml`](./.github/workflows/repo-scaffold-checks.yml): GPU を使わずに回せる構造チェック用 CI

## 補足

- [`benchmark_ollama.py`](./benchmark_ollama.py) は `</think>` より前の内容を除いて `visible_response_preview` を整えています。
- README の主張と証跡ファイルを対応づけられるように、関連ファイルをそのまま追跡しています。
- ラッパーは Windows 前提ですが、特定 1 台の絶対パスに固定されない形へ整えています。

## 制約

- 測定しているのは短い 1 系統のプロンプトのみです。
- ここにある結果はこの PC とこの取得時点の記録であり、一般化された性能主張ではありません。
- `ollama ps` の CPU/GPU 値は観測結果の記録であり、内部オフロードの詳細検証までは行っていません。
- cold start と warm start の切り分け、長時間安定性、他モデル比較は今回の範囲外です。

## 次の候補

- cold start と warm start を分けて記録する
- 英語プロンプトと日本語プロンプトを同じ JSON 形式で比較する
- 同じ証跡形式を他のローカルモデルにも広げる
