#!/bin/bash
# Check for similar existing components before creating new ones
# Usage: ./check-similar.sh <component-name> [search-dir]

COMPONENT_NAME="${1:-}"
SEARCH_DIR="${2:-frontend-react/src/components}"

if [ -z "$COMPONENT_NAME" ]; then
    echo "Usage: ./check-similar.sh <component-name> [search-dir]"
    exit 1
fi

# Convert to lowercase for case-insensitive search
LOWER_NAME=$(echo "$COMPONENT_NAME" | tr '[:upper:]' '[:lower:]')

echo "=== Searching for similar components to: $COMPONENT_NAME ==="
echo ""

# Search for exact match (case-insensitive)
echo "## Exact matches:"
find "$SEARCH_DIR" -type d -iname "$COMPONENT_NAME" 2>/dev/null | head -10
find "$SEARCH_DIR" -type f -iname "${COMPONENT_NAME}.tsx" 2>/dev/null | head -10

echo ""
echo "## Partial name matches:"
find "$SEARCH_DIR" -type d -iname "*${COMPONENT_NAME}*" 2>/dev/null | head -10
find "$SEARCH_DIR" -type f -iname "*${COMPONENT_NAME}*.tsx" 2>/dev/null | head -10

echo ""
echo "## Components with similar words:"
# Extract words from component name and search
for word in $(echo "$COMPONENT_NAME" | sed 's/\([A-Z]\)/ \1/g' | tr ' ' '\n' | grep -v '^$'); do
    if [ ${#word} -gt 3 ]; then
        find "$SEARCH_DIR" -type d -iname "*${word}*" 2>/dev/null | head -5
    fi
done | sort -u

echo ""
echo "=== End of search ==="
