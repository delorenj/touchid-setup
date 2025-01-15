#!/bin/bash
set -e

# Configuration
VERSION="v0.1.0"
REPO="delorenj/touchymcrootface"
FORMULA_PATH="../touchymcrootface-tap/Formula/touchymcrootface.rb"
BINARIES_DIR="."

# Calculate SHA256 hashes
echo "Calculating SHA256 hashes..."
ARM64_SHA=$(shasum -a 256 "$BINARIES_DIR/touchymcrootface-darwin-arm64" | cut -d' ' -f1)
AMD64_SHA=$(shasum -a 256 "$BINARIES_DIR/touchymcrootface-darwin-amd64" | cut -d' ' -f1)

echo "ARM64 SHA256: $ARM64_SHA"
echo "AMD64 SHA256: $AMD64_SHA"

# Update formula with actual hashes
sed -i '' "s/PLACEHOLDER_ARM64_SHA/$ARM64_SHA/" "$FORMULA_PATH"
sed -i '' "s/PLACEHOLDER_AMD64_SHA/$AMD64_SHA/" "$FORMULA_PATH"

echo "Formula updated with new hashes!"

# Create git tag if it doesn't exist
if ! git rev-parse $VERSION >/dev/null 2>&1; then
  echo "Creating git tag $VERSION..."
  git tag $VERSION
  echo "Don't forget to push the tag with: git push origin $VERSION"
fi

echo "Next steps:"
echo "1. Commit and push the formula changes"
echo "2. Create a GitHub release with version $VERSION"
echo "3. Upload the binary files to the release"
echo "4. Test with: brew install delorenj/touchymcrootface/touchymcrootface"