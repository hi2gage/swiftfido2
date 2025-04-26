#!/bin/zsh

echo "🔧 Running swift-format on all Swift files in the package..."

# Ensure we're in a Swift package directory
if [[ ! -f "Package.swift" ]]; then
  echo "❌ Not a Swift package directory."
  exit 1
fi

# Find all .swift files excluding .build and .git directories
FILES=($(find . -name "*.swift" \
  -not -path "./.build/*" \
  -not -path "./.git/*"))

# Format each file
for FILE in $FILES; do
  swift format format --configuration scripts/.swift-format.json -i "$FILE"
  echo "✅ Formatted: $FILE"
done

echo "🎉 Done formatting!"