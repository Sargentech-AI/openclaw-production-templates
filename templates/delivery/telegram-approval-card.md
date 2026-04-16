# Telegram Approval Cards

Send inline button cards to Telegram for human-in-the-loop approval workflows.

## Pattern

```python
# Python example using OpenClaw's message tool
# This sends a card with Approve/Rework buttons

import json
import subprocess

def send_approval_card(chat_id, task_id, title, summary):
    """Send a Telegram message with inline approve/rework buttons."""

    message = f"""🔍 QUALITY REVIEW — #{task_id}

{title}

{summary}
"""

    buttons = json.dumps([
        [
            {"text": "✅ Approve", "callback_data": f"aegis_approve_{task_id}"},
            {"text": "🔄 Rework", "callback_data": f"aegis_rework_{task_id}"}
        ]
    ])

    # Via OpenClaw message tool (in agent context):
    # message(action="send", target=f"telegram:{chat_id}",
    #         message=message, buttons=buttons)

    # Via CLI (outside agent context):
    # openclaw send --channel telegram --to <chat_id> --message "..." --buttons '[...]'
```

## Callback Handling

When a user clicks a button, OpenClaw delivers the `callback_data` as an inbound message to your main session.

```python
# In your agent's message handler:
if message.startswith("aegis_approve_"):
    task_id = message.split("_")[-1]
    # Process approval
elif message.startswith("aegis_rework_"):
    task_id = message.split("_")[-1]
    reason = message.split(" ", 1)[1] if " " in message else ""
    # Process rework request
```

## Best Practices

1. **Cap cards per batch** — max 5 cards per dispatch cycle to avoid Telegram flooding
2. **Track sent cards** — keep a state file of already-dispatched task IDs
3. **Idempotent callbacks** — handle duplicate button clicks gracefully
4. **Confirm actions** — send a brief confirmation after processing each callback
