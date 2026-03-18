#!/bin/bash
echo "Triggering Autonomous Security Audit..."
curl -s -X POST http://localhost:8000/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama3.1",
    "messages": [{"role": "user", "content": "Run security audit and fix vulnerabilities."}],
    "stream": false
  }' | jq '.message.content'