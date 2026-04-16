# Solo Consultant Setup

A complete OpenClaw production setup for a solo consultant or small business.

## Hardware

- Mac Mini or Mac Studio (Apple Silicon, 16GB+ RAM)
- Or any Linux server with 16GB+ RAM

## Software Stack

| Component | Purpose |
|-----------|---------|
| OpenClaw | Agent orchestration + gateway |
| Ollama | Local model inference |
| Telegram Bot | Delivery + approval interface |
| Mission Control | Task board (optional) |

## Models

| Model | Use Case | Cost |
|-------|----------|------|
| `qwen2.5:14b-instruct` | Research, writing, triage, monitoring | $0 (local) |
| `qwen2.5:7b-instruct` | Health checks, simple tasks | $0 (local) |
| `claude-sonnet-4-6` | Complex research, content drafting | ~$3/MTok |
| `claude-opus-4-6` | Coding, architecture decisions | ~$15/MTok |

## Cron Schedule

| Time | Job | Model | Purpose |
|------|-----|-------|---------|
| 5:30 AM | Morning briefing | Local 14B | News + weather + tasks |
| 6:30 AM | Marketing content | Cloud Sonnet | Draft social media |
| Every 5m | Health monitor | Local 7B | Gateway + provider checks |
| Every 1h | Pipeline watchdog | Local 14B | Detect stuck tasks |
| 2:00 PM | Research report | Cloud Sonnet | Deep-dive analysis |
| 6:00 PM | Daily recap | Local 14B | Memory + journal update |

## Monthly Cost Estimate

| Item | Cost |
|------|------|
| Hardware (amortized) | ~$100/month |
| Anthropic API (Sonnet) | ~$50-100/month |
| Anthropic API (Opus, coding only) | ~$50-150/month |
| Telegram Bot | Free |
| **Total** | **~$200-350/month** |

Compare to cloud-only: $800-1,500/month for equivalent workload.

## Setup Steps

1. Install OpenClaw: `npm install -g openclaw`
2. Install Ollama: `brew install ollama` (Mac) or see ollama.com
3. Pull models: `ollama pull qwen2.5:14b-instruct && ollama pull qwen2.5:7b-instruct`
4. Configure providers in `~/.openclaw/openclaw.json`
5. Create Telegram bot via @BotFather
6. Copy cron templates from `../templates/cron-jobs/`
7. Start: `openclaw gateway start`

## File Structure

```
~/.openclaw/
├── openclaw.json          # Main config
├── secrets.json           # API keys (gitignored)
├── cron/
│   └── jobs.json          # Cron job definitions
└── workspace/
    ├── SOUL.md            # Agent personality
    ├── USER.md            # Your profile
    ├── MEMORY.md          # Long-term memory
    ├── memory/            # Daily notes
    ├── brain/
    │   ├── docs/          # Knowledge base
    │   └── journal/       # Daily journal
    └── scripts/           # Custom scripts
```

For the complete guide with architecture decisions, debugging, and advanced patterns:
**[OpenClaw Production Setup Guide →](https://guide.sargentech.ai)**
