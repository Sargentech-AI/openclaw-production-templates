#!/bin/bash
# Provider Health Probe — check API availability before routing
#
# Tests each configured provider with a minimal request.
# Use in heartbeat checks or before expensive operations.

echo "=== Provider Health Check ==="
echo "Time: $(date)"
echo ""

# Ollama (local)
if curl -s --max-time 5 http://localhost:11434/api/tags > /dev/null 2>&1; then
  MODEL_COUNT=$(curl -s http://localhost:11434/api/tags | python3 -c "import sys,json; print(len(json.load(sys.stdin).get('models',[])))" 2>/dev/null)
  echo "✅ Ollama: UP ($MODEL_COUNT models loaded)"
else
  echo "❌ Ollama: DOWN or unreachable"
fi

# Anthropic
if [ -n "$ANTHROPIC_API_KEY" ]; then
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 \
    -X POST https://api.anthropic.com/v1/messages \
    -H "x-api-key: $ANTHROPIC_API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d '{"model":"claude-haiku-4-5","max_tokens":5,"messages":[{"role":"user","content":"."}]}')
  if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Anthropic: UP (HTTP $HTTP_CODE)"
  else
    echo "⚠️ Anthropic: HTTP $HTTP_CODE"
  fi
else
  echo "⏭️ Anthropic: No API key set"
fi

# OpenAI
if [ -n "$OPENAI_API_KEY" ]; then
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 \
    -X POST https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"model":"gpt-4o-mini","max_tokens":5,"messages":[{"role":"user","content":"."}]}')
  if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ OpenAI: UP (HTTP $HTTP_CODE)"
  else
    echo "⚠️ OpenAI: HTTP $HTTP_CODE"
  fi
else
  echo "⏭️ OpenAI: No API key set"
fi

echo ""
echo "Done."
