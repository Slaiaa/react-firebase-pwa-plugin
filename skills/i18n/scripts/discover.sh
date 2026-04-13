#!/bin/bash
# i18n Discovery Script
# Finds hardcoded strings in React/TypeScript applications

set -e

SEARCH_PATH="${1:-.}"
OUTPUT_FILE="${2:-i18n-discovery-report.md}"

echo "# i18n Discovery Report" > "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "Generated: $(date)" >> "$OUTPUT_FILE"
echo "Search path: $SEARCH_PATH" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Function to run search and count results
search_pattern() {
    local description="$1"
    local pattern="$2"
    local include="$3"

    echo "## $description" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"

    # Run grep and capture output
    local results
    results=$(grep -rn "$pattern" --include="$include" "$SEARCH_PATH" 2>/dev/null | head -50 || true)

    if [ -n "$results" ]; then
        echo "$results" >> "$OUTPUT_FILE"
        local count
        count=$(echo "$results" | wc -l | tr -d ' ')
        echo '```' >> "$OUTPUT_FILE"
        echo "Found: $count matches (showing first 50)" >> "$OUTPUT_FILE"
    else
        echo "No matches found" >> "$OUTPUT_FILE"
        echo '```' >> "$OUTPUT_FILE"
    fi
    echo "" >> "$OUTPUT_FILE"
}

echo "Running i18n discovery on: $SEARCH_PATH"
echo "Output will be saved to: $OUTPUT_FILE"
echo ""

# 1. JSX Text Content
search_pattern "JSX Text Content" ">[A-Z][a-z]" "*.tsx"

# 2. Title attributes
search_pattern "Title Attributes" 'title="[A-Za-z]' "*.tsx"

# 3. Placeholder text
search_pattern "Placeholder Text" 'placeholder="[A-Za-z]' "*.tsx"

# 4. ARIA labels
search_pattern "ARIA Labels" 'aria-label="[A-Za-z]' "*.tsx"

# 5. Alt text
search_pattern "Alt Text" 'alt="[A-Za-z]' "*.tsx"

# 6. Toast messages
search_pattern "Toast Messages" 'toast\.' "*.tsx"

# 7. Label props
search_pattern "Label Props" 'label="[A-Za-z]' "*.tsx"

# 8. Message/Description props
search_pattern "Message/Description Props" '\(message\|description\)="[A-Za-z]' "*.tsx"

# 9. Error text patterns
search_pattern "Error Text Patterns" '\(Error:\|Failed\|Unable to\|Cannot\)' "*.tsx"

# 10. Empty state patterns
search_pattern "Empty State Patterns" '\(No \|Nothing\|Empty\)' "*.tsx"

# 11. Loading states
search_pattern "Loading States" 'Loading' "*.tsx"

# 12. Button text
search_pattern "Button Text" '<Button[^>]*>[A-Za-z]' "*.tsx"

# 13. Header configs
search_pattern "Table Header Configs" 'header:.*["\x27][A-Za-z]' "*.tsx"

# Summary
echo "## Summary" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
total=$(grep -rn ">[A-Z][a-z]\|title=\"[A-Z]\|placeholder=\"[A-Z]\|aria-label=\"[A-Z]\|label=\"[A-Z]" --include="*.tsx" "$SEARCH_PATH" 2>/dev/null | wc -l || echo "0")
echo "Total potential hardcoded strings: ~$total" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "**Note**: Review each match - some may be intentionally not translated (e.g., brand names, code)." >> "$OUTPUT_FILE"

echo ""
echo "Discovery complete! Report saved to: $OUTPUT_FILE"
echo "Total potential matches: ~$total"
