#!/bin/bash

# 1. Capture Git context
STATUS=$(git status --short)
STAGED_DIFF=$(git diff --cached)
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$STAGED_DIFF" ]; then
    echo "❌ No staged changes found."
    exit 1
fi

# 2. Inline Prompt Definition (The "System Prompt")
SYSTEM_PROMPT="Act as a Git expert. Based on the provided context, you must generate a Git commit command.

IMPORTANT: Do NOT try to use any tools or functions like run_shell_command. 
Your ONLY goal is to output the plain text of the command.

Rules:
1. Generate a conventional commit message: <type>(<scope>): <description>
2. Use these types: feat, fix, docs, style, refactor, perf, test, build, ci, chore.
3. Include a detailed body if the changes are complex, explaining 'what' and 'why'.
4. Respond ONLY with the shell command. Do not include explanations.

Format:
You must wrap the message in a HEREDOC exactly like this:
git commit -m \"\$(cat <<'EOF'
<type>(<scope>): <description>

[optional body]
EOF
)\""

# 3. Combine everything
FULL_PROMPT="$SYSTEM_PROMPT

Context:
BRANCH: $BRANCH
STATUS: $STATUS
DIFF: $STAGED_DIFF"

echo "🤖 Consulting Gemini..."

# 4. Get response and clean Markdown code blocks
RAW_RESPONSE=$(NODE_NO_WARNINGS=1 gemini "$FULL_PROMPT" --model gemini-2.5-flash)
# Remove markdown code fences (```bash or ```)
CLEAN_RESPONSE=$(echo "$RAW_RESPONSE" | sed -e 's/^```.*//g')

echo -e "\nGemini's proposal:"
echo "------------------------------------------------"
echo "$CLEAN_RESPONSE"
echo "------------------------------------------------"
echo ""

# 5. Execution logic
read -p "Execute this command? (y/n): " CONFIRM
if [ "$CONFIRM" = "y" ]; then
    TEMP_SCRIPT=$(mktemp)
    echo "$CLEAN_RESPONSE" > "$TEMP_SCRIPT"
    bash "$TEMP_SCRIPT"
    rm "$TEMP_SCRIPT"
    echo "✅ Commit created successfully."
else
    echo "Operation cancelled."
fi