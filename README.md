# OpenClaw Production Templates

Production-ready configuration templates for [OpenClaw](https://github.com/openclaw/openclaw) agent deployments.

Built from running a multi-agent production stack for 6+ months. These are the patterns that survived contact with reality.

## What's Inside

### `/templates/cron-jobs/`
Ready-to-use cron job configurations for common agent workflows:
- **Morning briefing** — daily news + weather + task summary delivered to Telegram
- **Research pipeline** — automated deep-dive research on rotating topics
- **Marketing content** — draft social media content for human approval
- **Health monitoring** — gateway, provider, and model health checks
- **Pipeline watchdog** — detect stuck tasks and stale queues

### `/templates/agent-profiles/`
Agent configuration profiles for different workload types:
- **Worker agents** — task-specific profiles for research, writing, code, QA
- **Orchestrator** — main session profile with full tool access
- **Lightweight** — minimal context profiles for background jobs

### `/templates/monitoring/`
Scripts and configs for production monitoring:
- **Drift detector** — catch when cron jobs silently switch to expensive models
- **Provider health probe** — check API availability before routing
- **Cost tracker** — per-model usage aggregation

### `/templates/delivery/`
Message delivery patterns:
- **Telegram approval cards** — inline buttons for approve/rework workflows
- **Quality review gates** — human-in-the-loop before external actions
- **Failure alerting** — escalation chains for cron failures

### `/examples/`
Complete working examples combining multiple templates:
- **Solo consultant setup** — single Mac, 3 agent workers, Telegram delivery
- **Small team setup** — shared task board, multiple reviewers, Slack/Teams delivery

## Quick Start

```bash
# Clone the templates
git clone https://github.com/Sargentech-AI/openclaw-production-templates.git
cd openclaw-production-templates

# Copy a cron template
cp templates/cron-jobs/morning-briefing.json ~/.openclaw/cron/

# Edit for your setup
# - Set your Telegram chat ID
# - Choose your model (local or cloud)
# - Set your timezone
```

## Design Principles

1. **Human-in-the-loop by default** — nothing goes external without approval
2. **Local-first inference** — use cloud APIs only when local models can't handle it
3. **Fail gracefully** — every template includes fallback chains and error handling
4. **Observable** — audit logs, delivery confirmations, drift detection

## Real Numbers

These templates run our production stack:
- **50+ tasks/week** through a 6-worker pipeline
- **80% local inference** on a Mac Studio (Qwen 14B + Gemma 4)
- **~$400/month blended cost** vs $1,000+/month cloud-only
- **Zero unreviewed external sends** — every output passes quality gates

## Requirements

- [OpenClaw](https://github.com/openclaw/openclaw) installed and running
- A Telegram bot (for delivery — optional but recommended)
- At least one LLM provider configured (local Ollama or cloud API)

## Full Guide

These templates are extracted from our complete production setup documentation.

For the full walkthrough — including architecture decisions, debugging guides, and advanced patterns:

**[OpenClaw Production Setup Guide →](https://guide.sargentech.ai)**

## License

MIT — use these however you want.

## Contributing

Found a bug or have a better pattern? Open an issue or PR.

---

Built by [Sargentech AI](https://github.com/Sargentech-AI) · [@SargenTech_AI](https://x.com/SargenTech_AI) · Brisbane, Australia
