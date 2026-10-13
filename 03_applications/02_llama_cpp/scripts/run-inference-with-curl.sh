#!/bin/bash

NODE="node1"
PORT="8080"
[[ $# -eq 2 ]] && NODE=$1 && PORT=$2
curl http://$NODE:$PORT/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant."
      },
      {
        "role": "user",
        "content": "Why is the sky blue?"
      }
    ],
    "temperature": 0.7,
    "max_tokens": 150
  }'

  echo ""