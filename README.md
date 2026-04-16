# OpenClaw Production Templates

Production-ready configuration templates for [OpenClaw](https://github.com/openclaw/openclaw) agent deployments.

Built from running a multi-agent production stack for 6+ months. These are the patterns that survived contact with reality.

## What this repo is for
Use this repo when you want reusable production patterns:
- cron job templates
- worker profile templates
- monitoring hooks
- delivery / approval patterns

This repo is not the full company profile. For broader context, products, and links, see the org profile and `sargentech-ai` repo.

## Proof and examples
- Architecture / flow diagram: [`assets/production-flow.svg`](assets/production-flow.svg)
- Example approval card: [`assets/approval-card-example.svg`](assets/approval-card-example.svg)
- End-to-end walkthrough: [`examples/end-to-end-reviewed-delivery.md`](examples/end-to-end-reviewed-delivery.md)
- Solo consultant example: [`examples/solo-consultant-setup.md`](examples/solo-consultant-setup.md)

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
- **Lightweight** — minimal context profiles for background jobs

### `/templates/monitoring/`
Scripts and configs for production monitoring:
- **Drift detector** — catch when cron jobs silently switch to expensive models
- **Provider health probe** — check API availability before routing

### `/templates/delivery/`
Message delivery patterns:
- **Telegram approval cards** — inline buttons for approve/rework workflows
- **Quality review gates** — human-in-the-loop before external actions

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
3. **Fail gracefully** — templates include fallback and monitoring hooks
4. **Observable** — audit logs, delivery confirmations, drift detection

## Reality check
These templates reflect one specific operating philosophy:
- route cheap work cheaply
- keep review gates load-bearing
- make drift visible
- prefer explicit failure over silent bad delivery

## Requirements
- [OpenClaw](https://github.com/openclaw/openclaw) installed and running
- A Telegram bot (optional but recommended for approval workflows)
- At least one LLM provider configured (local Ollama or cloud API)

## Full guide
For the full walkthrough — architecture decisions, debugging guides, and advanced patterns:

**[OpenClaw Production Setup Guide →](https://guide.sargentech.ai)**

## License
MIT — use these however you want.
