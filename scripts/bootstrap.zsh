#!/bin/zsh

if [[ ! -d .git ]]; then
  echo "❌ Not a Git repository. Run this from the root of your Swift package."
  exit 1
fi

mkdir -p .git/hooks

echo $PWD

# --- pre-commit scripts ---
echo ""
echo "🧹 Installing pre-commit hook..."

PRE_COMMIT_SOURCE="scripts/bootstrap/pre-commit"
PRE_COMMIT_TARGET=".git/hooks/pre-commit"

if [[ -e $PRE_COMMIT_TARGET ]]; then
  echo "  🔁 Replacing existing pre-commit hook..."
  rm -f $PRE_COMMIT_TARGET
fi

cp "$PRE_COMMIT_SOURCE" "$PRE_COMMIT_TARGET"
chmod +x "$PRE_COMMIT_TARGET"

echo "  ✅ Installed pre-commit hook from $PRE_COMMIT_SOURCE"


# --- Other setup ---


# --- done ---
echo ""
echo "🎉 Bootstrap complete!"