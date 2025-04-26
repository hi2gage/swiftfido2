#!/bin/zsh

echo "🔧 Running swift-format on staged Swift files..."

# Ensure we're in a Swift package directory
if [[ ! -f "Package.swift" ]]; then
  echo "❌ Not a Swift package directory."
  exit 1
fi

# Get list of staged .swift files (Added, Copied, or Modified)
STAGED_FILES=($(git diff --cached --name-only --diff-filter=ACM | grep '\.swift$'))

if [[ ${#STAGED_FILES[@]} -eq 0 ]]; then
  echo "ℹ️  No staged Swift files to format."
  exit 0
fi

# Track which files were actually modified by formatting
MODIFIED=()

for FILE in "${STAGED_FILES[@]}"; do
  if [[ -f "$FILE" ]]; then
    SHA_BEFORE=$(git hash-object "$FILE")

    # Format the file in-place
    swift format format --configuration scripts/.swift-format.json -i "$FILE"

    SHA_AFTER=$(git hash-object "$FILE")

    if [[ "$SHA_BEFORE" != "$SHA_AFTER" ]]; then
      MODIFIED+=("$FILE")
      echo "✅ Formatted: $FILE"
      git add "$FILE"
    fi
  fi
done

if [[ ${#MODIFIED[@]} -eq 0 ]]; then
  echo "🎉 No changes needed!"
else
  echo "🔁 Updated and restaged ${#MODIFIED[@]} file(s)."
fi