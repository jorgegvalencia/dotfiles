#!/bin/bash

# Capture Git context
STATUS=$(git status --short)
STAGED_DIFF=$(git diff --cached)
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$STAGED_DIFF" ]; then
    echo "❌ No staged changes found (use 'git add' first)."
    exit 1
fi

# Build the prompt with strict formatting instructions
PROMPT="Act as a Git expert. Based on these changes:
BRANCH: $BRANCH
STATUS: $STATUS
DIFF: $STAGED_DIFF

Instructions:
1. Generate a conventional commit message: <type>(<scope>): <description>
2. Use these types: feat, fix, docs, style, refactor, perf, test, build, ci, chore.
3. Include an optional body if the changes are complex.
4. Respond ONLY with the command using a HEREDOC exactly like this:

git commit -m \"\$(cat <<'EOF'
<type>(<scope>): <description>

[optional body]
EOF
)\""

echo "🤖 Consulting Gemini..."

# Send to gemini-cli and capture response
RESPONSE=$(gemini --prompt "$PROMPT")

echo -e "\nGemini's proposal:"
echo -e "👉 $RESPONSE\n"

read -p "Execute this command? (y/n): " CONFIRM
if [ "$CONFIRM" = "y" ]; then
    eval "$RESPONSE"
else
    echo "Operation cancelled."
fi