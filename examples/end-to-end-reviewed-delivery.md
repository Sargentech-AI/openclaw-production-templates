# End-to-End Example — Research to Reviewed Delivery

This example shows how the templates fit together in a small production stack.

## Flow
1. A cron job triggers a research task.
2. The worker profile routes the task to the right model.
3. The worker produces a draft.
4. A quality review gate stops external delivery.
5. A Telegram approval card is sent.
6. Only approved output is delivered.

## Why this matters
This is the difference between a demo agent and a production agent system:
- routing discipline
- explicit review state
- recoverable failure points
- no unreviewed external sends

## Files involved
- `templates/cron-jobs/research-pipeline.json`
- `templates/agent-profiles/worker-research.json`
- `templates/delivery/telegram-approval-card.md`
- `templates/monitoring/drift-detector.sh`

## Visual proof
- Flow diagram: [`../assets/production-flow.svg`](../assets/production-flow.svg)
- Approval card mock: [`../assets/approval-card-example.svg`](../assets/approval-card-example.svg)
