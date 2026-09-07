from __future__ import annotations

import argparse
import json
import statistics
import sys
import urllib.error
import urllib.request


def strip_think_block(text: str) -> str:
    marker = "</think>"
    if marker not in text:
        return text.strip()
    return text.split(marker, 1)[1].strip()


def post_json(url: str, payload: dict) -> dict:
    request = urllib.request.Request(
        url,
        data=json.dumps(payload, ensure_ascii=False).encode("utf-8"),
        headers={"Content-Type": "application/json; charset=utf-8"},
        method="POST",
    )
    with urllib.request.urlopen(request, timeout=600) as response:
        return json.loads(response.read().decode("utf-8"))


def get_json(url: str) -> dict:
    request = urllib.request.Request(url, method="GET")
    with urllib.request.urlopen(request, timeout=30) as response:
        return json.loads(response.read().decode("utf-8"))


def format_rate(tokens: int, duration_ns: int) -> float:
    if duration_ns <= 0:
        return 0.0
    return tokens / (duration_ns / 1_000_000_000)


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    if hasattr(sys.stderr, "reconfigure"):
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")

    parser = argparse.ArgumentParser(
        description="Run a local Ollama generate call and print a compact benchmark summary."
    )
    parser.add_argument("--host", default="http://127.0.0.1:11434", help="Ollama host URL")
    parser.add_argument("--model", default="nemotron-3-nano:4b", help="Model tag")
    parser.add_argument("--num-ctx", type=int, default=2048, help="Requested context length")
    parser.add_argument("--repeat", type=int, default=1, help="How many sequential runs to execute")
    parser.add_argument(
        "--prompt",
        default="Reply with exactly three short bullet points about why compact local models are useful.",
        help="Prompt to send",
    )
    parser.add_argument(
        "--save-response",
        default="",
        help="Optional UTF-8 text file path for the raw response body",
    )
    args = parser.parse_args()

    if args.repeat < 1:
        print("--repeat must be 1 or greater", file=sys.stderr)
        return 6

    tags_url = f"{args.host}/api/tags"
    generate_url = f"{args.host}/api/generate"

    try:
        tags = get_json(tags_url)
    except urllib.error.URLError as exc:
        print(f"Failed to reach Ollama at {args.host}: {exc}", file=sys.stderr)
        return 2

    available_models = {model["name"] for model in tags.get("models", [])}
    if args.model not in available_models:
        print(
            f"Model {args.model!r} is not installed. Available: {sorted(available_models)}",
            file=sys.stderr,
        )
        return 3

    payload = {
        "model": args.model,
        "prompt": args.prompt,
        "stream": False,
        "options": {"num_ctx": args.num_ctx},
    }

    runs = []
    result = {}
    visible_response = ""
    for index in range(args.repeat):
        try:
            result = post_json(generate_url, payload)
        except urllib.error.HTTPError as exc:
            body = exc.read().decode("utf-8", errors="replace")
            print(f"Ollama generate failed: {exc.code} {exc.reason}\n{body}", file=sys.stderr)
            return 4
        except urllib.error.URLError as exc:
            print(f"Ollama generate failed: {exc}", file=sys.stderr)
            return 5

        visible_response = strip_think_block(result.get("response", ""))
        runs.append(
            {
                "run": index + 1,
                "total_seconds": round(result.get("total_duration", 0) / 1_000_000_000, 3),
                "load_seconds": round(result.get("load_duration", 0) / 1_000_000_000, 3),
                "prompt_eval_count": result.get("prompt_eval_count", 0),
                "prompt_eval_rate_tps": round(
                    format_rate(
                        result.get("prompt_eval_count", 0),
                        result.get("prompt_eval_duration", 0),
                    ),
                    2,
                ),
                "eval_count": result.get("eval_count", 0),
                "eval_rate_tps": round(
                    format_rate(result.get("eval_count", 0), result.get("eval_duration", 0)),
                    2,
                ),
            }
        )

    if args.save_response:
        with open(args.save_response, "w", encoding="utf-8") as handle:
            handle.write(result.get("response", ""))

    eval_rates = [run["eval_rate_tps"] for run in runs]
    total_seconds = [run["total_seconds"] for run in runs]
    load_seconds = [run["load_seconds"] for run in runs]
    summary = {
        "model": result.get("model"),
        "done": result.get("done"),
        "done_reason": result.get("done_reason"),
        "repeat": args.repeat,
        "response_chars": len(result.get("response", "")),
        "response_preview": result.get("response", "")[:240],
        "visible_response_chars": len(visible_response),
        "visible_response_preview": visible_response[:240],
        "total_seconds": runs[-1]["total_seconds"],
        "load_seconds": runs[-1]["load_seconds"],
        "prompt_eval_count": result.get("prompt_eval_count", 0),
        "prompt_eval_rate_tps": runs[-1]["prompt_eval_rate_tps"],
        "eval_count": result.get("eval_count", 0),
        "eval_rate_tps": runs[-1]["eval_rate_tps"],
        "num_ctx": args.num_ctx,
        "runs": runs,
    }
    if args.repeat > 1:
        summary["aggregate"] = {
            "eval_rate_tps_avg": round(statistics.fmean(eval_rates), 2),
            "eval_rate_tps_median": round(statistics.median(eval_rates), 2),
            "eval_rate_tps_min": round(min(eval_rates), 2),
            "eval_rate_tps_max": round(max(eval_rates), 2),
            "total_seconds_avg": round(statistics.fmean(total_seconds), 3),
            "load_seconds_avg": round(statistics.fmean(load_seconds), 3),
        }

    print(json.dumps(summary, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
